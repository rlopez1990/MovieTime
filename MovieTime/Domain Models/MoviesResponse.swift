//
//  MoviesResponse.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import Foundation

struct MoviesResponse: Decodable {
    let page: Int
    let results: [ResultResponse]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
