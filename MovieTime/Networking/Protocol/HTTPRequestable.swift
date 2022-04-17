//
//  HTTPRequestable.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 12/04/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol HTTPRequestable {
    associatedtype Response: Decodable
    
    var urlPath: String { get }
    var method: HTTPMethod { get }
    var queryItem: [URLQueryItem] { get }
}
