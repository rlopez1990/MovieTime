//
//  HTTPClient.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 12/04/22.
//

import Foundation

protocol HTTPClient: AnyObject {
    var baseURL: String { get set }
    
    func execute<Request: HTTPRequestable>(request: Request,
                                           completion: @escaping (HTTPResponse<Request.Response>) -> Void)
}
