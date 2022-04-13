//
//  URLSessionHTTPClient.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 12/04/22.
//

import Foundation

final class URLSessionHTTPClient {
    private let bodyEncoder: JSONEncoder
    private let responseDecoder: JSONDecoder
    private let urlSession: URLSession

    var baseURL: String

    init(baseURL: String,
         urlSession: URLSession,
         bodyEncoder: JSONEncoder = .init(),
         responseEncoder: JSONDecoder = .init()) {
        self.baseURL = baseURL
        self.urlSession = urlSession
        self.bodyEncoder = bodyEncoder
        self.responseDecoder = responseEncoder
    }
}

// MARK: - HTTPClient
extension URLSessionHTTPClient: HTTPClient {

    private struct Constants {
        static let httpSuccessfulCodeRange = 200...299
    }

    func execute<Request>(request: Request,
                          completion: @escaping (HTTPResponse<Request.Response>) -> Void) where Request : HTTPRequest {
        let responseFactory = HTTPResponseFactory<Request>()
        do {
            let urlRequest = try createURLRequest(for: request)
            let task = urlSession.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
                guard let self = self,
                    let httpResponse = urlResponse as? HTTPURLResponse else {
                        let noInternet = (error as NSError?)?.code == NSURLErrorNotConnectedToInternet
                        completion(responseFactory.creteFailureResponse(error: noInternet ? .noConection : .unknown))
                        return
                }
                responseFactory.httpResponse = httpResponse
                guard Constants.httpSuccessfulCodeRange.contains(httpResponse.statusCode) else {
                    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("[DEBUG] Error Response: \(json)")
                    }
                    completion(responseFactory.creteFailureResponse(error: .httpError(error: error)))
                    return
                }
                completion(self.decodeResponse(response: request,
                                               urlRequest: urlRequest,
                                               httpResponse: httpResponse,
                                               data: data,
                                               error: error))
            }
            task.resume()
        } catch {
            guard let decodeError = error as? HTTPResponse<Request.Response>.Error else {
                completion(responseFactory.creteFailureResponse(error: .unknown))
                return
            }
            completion(responseFactory.creteFailureResponse(error: decodeError))
        }
    }
}
