//
//  Requests.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import Foundation

struct MovieRequest: HTTPRequestable {
    typealias Response = MoviesResponse

    let urlPath: String
    let method: HTTPMethod
    let queryItem: [URLQueryItem]
}

struct MovieDetailRequest: HTTPRequestable {
    typealias Response = MovieDetailResponse

    let urlPath: String
    let method: HTTPMethod
    let queryItem: [URLQueryItem]
}
