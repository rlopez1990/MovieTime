//
//  ResultResponse.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import Foundation

struct ResultResponse: Decodable {
    let adult: Bool
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
