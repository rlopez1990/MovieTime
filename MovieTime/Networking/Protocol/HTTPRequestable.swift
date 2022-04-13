//
//  HTTPRequestable.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 12/04/22.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

protocol HTTPRequestable {
    associatedtype Body: Decodable
    associatedtype Response: Decodable
    
    var urlPath: String { get }
    var method: HTTPMethod { get }
    var body: Body? { get }
}
