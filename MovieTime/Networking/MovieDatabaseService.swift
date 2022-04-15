//
//  MovieDatabaseService.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import Foundation

struct PopularRequest: HTTPRequestable {
    struct Body: Codable { }
    typealias Response = [MoviesResponse]

    var urlPath: String
    var method: HTTPMethod = .get
    var body: Body? = nil

     init(urlPath: String = "/api/statuses/user_timeline") {
        self.urlPath = urlPath
    }
}

final class MovieDatabaseService {

    private enum Constants {
        static let baseURL = "https://api.themoviedb.org/3/movie"
        static let apiKey = "82d42b87bf93398ab90c0488a4b3babc"
    }

    private static var httpClient: HTTPClient = {
        let urlSession = URLSession(configuration: .default,
                                    delegate: nil,
                                    delegateQueue: nil)
        return URLSessionHTTPClient(baseURL: Constants.baseURL, urlSession: urlSession)
    }()

    private let httpClient: HTTPClient

    init(httpCliente: HTTPClient = MovieDatabaseService.httpClient) {
        self.httpClient = httpCliente
    }
}
