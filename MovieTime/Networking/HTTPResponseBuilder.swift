//
//  HTTPResponseBuilder.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 13/04/22.
//

import Foundation

final class HTTPResponseBuilder<Request: HTTPRequestable> {
    private var urlRequest: URLRequest?
    private var httpResponse: HTTPURLResponse?

    init() {
        // It's empty beacuse there are some cases where we only need a basic failure case
    }
    
    func update(urlRequest: URLRequest?, httpResponse: HTTPURLResponse?) {
        self.urlRequest = urlRequest
        self.httpResponse = httpResponse
    }
    
    func createSuccessfulResponse(response: Request.Response) -> HTTPResponse<Request.Response> {
        return .init(urlRequest: urlRequest,
                     httpResponse: httpResponse,
                     result: .success(response))
    }

    func creteFailureResponse(error: HTTPResponse<Request.Response>.Error) -> HTTPResponse<Request.Response> {
        return .init(urlRequest: urlRequest,
                     httpResponse: httpResponse,
                     result: .failure(error))
    }
}
