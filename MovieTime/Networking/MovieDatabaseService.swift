//
//  MovieDatabaseService.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import Foundation

struct MovieRequest: HTTPRequestable {
    struct Body: Codable { }
    typealias Response = MoviesResponse

    let urlPath: String
    let method: HTTPMethod
    let body: Body?
    let queryItem: [URLQueryItem]
}

typealias MoviewResult = Result<MoviesResponse, Error>
typealias MoviewCompletion = (MoviewResult) -> Void

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

    func getMovies(from searchType: SearchType, page: Int, completion: @escaping MoviewCompletion) {
        let items = commonQueryItem(with: page)
        let request = createResquest(from: searchType, page: page,queryItem: items)
        getMovies(from: request, completion: completion)
    }

    func searchMovies(word: String, page: Int, completion: @escaping MoviewCompletion) {
        let request = createRequest(for: word, page: page)
        getMovies(from: request, completion: completion)
    }
}

private extension MovieDatabaseService {

    func getMovies(from movieRequest: MovieRequest, completion: @escaping MoviewCompletion) {
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
                     body: nil,
                     queryItem: queryItem)
    }

    func createRequest(for word: String, page: Int) -> MovieRequest {
        var newQueryItems = commonQueryItem(with: page)
        newQueryItems.append(URLQueryItem(name: "query", value: word))
        return createResquest(from: .search,
                              page: page,
                              queryItem: newQueryItems)
    }

    func commonQueryItem(with page: Int) -> [URLQueryItem] {
        return [URLQueryItem(name: "page", value: page.description),
                URLQueryItem(name: "api_key", value: Constants.apiKey)]
    }
}
