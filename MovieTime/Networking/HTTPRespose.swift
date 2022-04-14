//
//  HTTPRespose.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 12/04/22.
//

import Foundation

struct HTTPResponse<Model> {
    enum Error: Swift.Error {
        case unknown
        case noConection
        case badStructure
        case serviceError
        case httpError(error: Swift.Error?)
        case badBodyEncodable(error: Swift.Error)
    }
    let urlRequest: URLRequest?
    let httpResponse: HTTPURLResponse?
    let result: Result<Model, Error>
}
