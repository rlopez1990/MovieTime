//
//  URLSessionHTTPClient.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 12/04/22.
//

import Foundation
import UIKit

final class URLSessionHTTPClient {

    // MARK: - Private methods
    private var baseURL: String
    private let urlSession: URLSession
    private let bodyEncoder: JSONEncoder
    private let responseDecoder: JSONDecoder

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

enum ImageQuality: String {
    case lowQuality = "w200"
}

// MARK: - HTTPClient
extension URLSessionHTTPClient: HTTPClient {

    private enum Constants {
        static let httpSuccessfulCodeRange = 200...299
    }

    func execute<Request>(request: Request,
                          completion: @escaping (HTTPResponse<Request.Response>) -> Void) where Request : HTTPRequestable {
        let responseBuilder = HTTPResponseBuilder<Request>()
        do {
            let urlRequest = try createURLRequest(for: request, baseURL: baseURL)
            let task = createDataTask(responseBuilder: responseBuilder, urlRequest: urlRequest, completion: completion)
            task.resume()
        } catch {
            guard let decodeError = error as? HTTPResponse<Request.Response>.Error else {
                completion(responseBuilder.creteFailureResponse(error: .unknown))
                return
            }
            completion(responseBuilder.creteFailureResponse(error: decodeError))
        }
    }

    func fetchImage(path: String, quality: ImageQuality, completion: @escaping (UIImage?) -> Void) {
        let fullStringURL = baseURL + "/t/p/" + quality.rawValue + path
        guard let imageURL = URL(string: fullStringURL) else {
            completion(nil)
            return
        }
        let task = urlSession.dataTask(with: imageURL) { data, response, error in
            guard error == nil,
                  let httpResponse = response as? HTTPURLResponse,
                  Constants.httpSuccessfulCodeRange.contains(httpResponse.statusCode),
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}

// MARK: - Private Methods
private extension URLSessionHTTPClient {
    /// Creates `URLRequest` object with a request  (customizable object) as paramerter
    /// - Returns: A object which conforms the `HTTPRequestable` protocol
    func createURLRequest<Request: HTTPRequestable>(for request: Request, baseURL: String) throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + request.urlPath) else {
            throw HTTPResponse<Request.Response>.Error.badStructure
        }
        if !request.queryItem.isEmpty {
            components.queryItems = request.queryItem
        }
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.cachePolicy = .reloadRevalidatingCacheData
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    func createDataTask<Request: HTTPRequestable>(responseBuilder: HTTPResponseBuilder<Request>, urlRequest: URLRequest, completion: @escaping (HTTPResponse<Request.Response>) -> Void) -> URLSessionDataTask {
       return urlSession.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
           if let self = self,
               let httpResponse = urlResponse as? HTTPURLResponse {
                responseBuilder.update(urlRequest: urlRequest,
                                       httpResponse: httpResponse)
                
                if Constants.httpSuccessfulCodeRange.contains(httpResponse.statusCode) {
                    completion(self.createResponse(responseBuilder: responseBuilder, data: data, error: error))
                } else {
                    completion(responseBuilder.creteFailureResponse(error: .httpError(error: error)))
                }
            } else {
                let noInternet = (error as NSError?)?.code == NSURLErrorNotConnectedToInternet
                completion(responseBuilder.creteFailureResponse(error: noInternet ? .noConection : .unknown))
            }
        }
    }

    func createResponse<Request: HTTPRequestable>(responseBuilder: HTTPResponseBuilder<Request>,
                                                  data: Data?,
                                                  error: Error?) -> HTTPResponse<Request.Response> {
        switch (error: error, data: data) {
        case (error: .some(let requestError), data: _):
            return responseBuilder.creteFailureResponse(error: .httpError(error: requestError))
        case (error: .none, data: .some(let responseData)):
            do {
                let decodedResponse = try responseDecoder.decode(Request.Response.self, from: responseData)
                return responseBuilder.createSuccessfulResponse(response: decodedResponse)
            } catch let error {
                return responseBuilder.creteFailureResponse(error: .badBodyEncodable(error: error))
            }
        case (error: .none, data: .none):
            return responseBuilder.creteFailureResponse(error: .serviceError)
        }
    }
}
