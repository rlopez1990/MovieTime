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
    }
    let urlRequest: URLRequest?
    let htttResponse: HTTPURLResponse?
    let result: Result<Model, Error>
}
