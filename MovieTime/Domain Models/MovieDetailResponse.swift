//
//  MovieDetailResponse.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import Foundation

struct MovieDetailResponse: Decodable {
    let backdropPath: String
    let genres: [Genre]
    let originalLanguage, originalTitle, overview: String
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let releaseDate: String
    let spokenLanguages: [SpokenLanguage]
    let title: String
    let video: Bool
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case spokenLanguages = "spoken_languages"
        case title, video
        case voteAverage = "vote_average"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case name
    }
}
