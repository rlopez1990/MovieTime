//
//  MovieDatabaseService.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import Foundation

typealias MovieCompletion = (Result<MoviesResponse, Error>) -> Void
typealias MovieDetailCompletion = (Result<MovieDetailResponse, Error>) -> Void

enum SearchType: String {
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    case movieDetail = "movie"
    case search = "search/movie"
}

final class MovieDatabaseService: MainThreadExecutable {

    private enum Constants {
        static let baseURL = "https://api.themoviedb.org"
        static let apiKey = "82d42b87bf93398ab90c0488a4b3babc"
    }

    private static var httpClient: HTTPClient = {
        let urlSession = URLSession(configuration: .default,
                                    delegate: nil,
                                    delegateQueue: nil)
        return URLSessionHTTPClient(baseURL: Constants.baseURL, urlSession: urlSession)
    }()

    private let httpClient: HTTPClient

    // MARK: - Initializer
    init(httpClient: HTTPClient = MovieDatabaseService.httpClient) {
        self.httpClient = httpClient
    }

    func getMovies(from searchType: SearchType, page: Int, completion: @escaping MovieCompletion) {
        let items = commonQueryItem(with: page)
        let request = createResquest(from: searchType, page: page,queryItem: items)
        getMovies(from: request, completion: completion)
    }

    func getMovieDetails(movieIdentifier: String, completion: @escaping MovieDetailCompletion) {
        let request = createMovieDetailRequest(for: movieIdentifier)
        getMovies(from: request, completion: completion)
    }

    func searchMovies(word: String, page: Int, completion: @escaping MovieCompletion) {
        let request = createRequest(for: word, page: page)
        getMovies(from: request, completion: completion)
    }
}

private extension MovieDatabaseService {

    func getMovies<Request: HTTPRequestable>(from movieRequest: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        let mainThread = completionOnMainThread(completion: completion)
        httpClient.execute(request: movieRequest) { response in
            switch response.result {
            case .success(let movieResponse):
                mainThread(.success(movieResponse))
            case .failure(let error):
                mainThread(.failure(error))
            }
        }
    }

    func createResquest(from searchType: SearchType, page: Int, queryItem: [URLQueryItem]) -> MovieRequest {
        let path = "/3/" + searchType.rawValue
        return .init(urlPath: path,
                     method: .get,
                     queryItem: queryItem)
    }

    func createRequest(for word: String, page: Int) -> MovieRequest {
        var newQueryItems = commonQueryItem(with: page)
        newQueryItems.append(contentsOf: [URLQueryItem(name: "query", value: word),
                                          URLQueryItem(name: "language", value: "en-US"),
                                          URLQueryItem(name: "include_adult", value: "false")])
        //(URLQueryItem(name: "query", value: word))
        return createResquest(from: .search,
                              page: page,
                              queryItem: newQueryItems)
    }

    func createMovieDetailRequest(for movieIdentifier: String) -> MovieDetailRequest {
        let path = "/3/" + SearchType.movieDetail.rawValue + "/" + movieIdentifier

        return .init(urlPath: path,
                     method: .get,
                     queryItem: [apiKeyQueryItem()])
    }

    func commonQueryItem(with page: Int) -> [URLQueryItem] {
        return [URLQueryItem(name: "page", value: page.description),
                apiKeyQueryItem()]
    }

    func apiKeyQueryItem() -> URLQueryItem {
        return URLQueryItem(name: "api_key", value: Constants.apiKey)
    }
}
