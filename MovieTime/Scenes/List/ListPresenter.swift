//
//  PopularPresenter.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

typealias CategoryListPresentable = CategoryFetchable & ListPressentable

protocol CategoryFetchable {
    func fetchData(from searchType: SearchType)
}

final class ListPresenter {
    weak var view: ListMoviesDisplayable?
    var elements: [PosterViewModel] = []
    let viewCoordinator: ViewCoordinator
    var total = 0

    // MARK: - Private properties
    private var dataService: MovieDatabaseService
    private var page = 1
    private var isFeching = false
    private var reachability: NetworkReachability
    private var codableStorage: CodableStorage

    init(view: ListMoviesDisplayable?,
         dataService: MovieDatabaseService = MovieDatabaseService(),
         viewCoordinator: ViewCoordinator = ViewCoordinator(),
         reachability: NetworkReachability = NetworkReachability(),
         codableStorage: CodableStorage = CodableStorage()) {
        self.view = view
        self.dataService = dataService
        self.viewCoordinator = viewCoordinator
        self.reachability = reachability
        self.codableStorage = codableStorage
    }
}

extension ListPresenter: CategoryListPresentable {

    func fetchData(from searchType: SearchType) {
        guard !isFeching else { return }
        if page == 1 {
            view?.showLoader()
        }

        if reachability.checkConnection() {
            makeRequest(searchType: searchType)
        } else {
            loadOffLineData(searchType: searchType)
        }
    }
}

// MARK: - Private methods
private extension ListPresenter {

    func loadOffLineData(searchType: SearchType) {
        guard let viewModels = try? codableStorage.retrieve("user.sessionId", as: [PosterViewModel].self) else {
            return
        }
        isFeching = false

        view?.dissmissLoader()
        total = viewModels.count
        elements = viewModels
        view?.loadFirstPage()
    }

    func makeRequest(searchType: SearchType) {
        dataService.getMovies(from: searchType, page: page) { [weak self] result in
            switch result {
            case.success(let movieResponse):
                self?.handleResponse(movieResponse: movieResponse, searchType: searchType)
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }

    func handleResponse(movieResponse: MoviesResponse, searchType: SearchType) {
        view?.dissmissLoader()

        page += 1
        isFeching = false
        updateTotalIfNeeded(totalResults: movieResponse.totalResults)

        let items = viewModels(from: movieResponse.results)
        elements.append(contentsOf: items)

        if movieResponse.page > 1 {
            let indexPaths = calculateIndexPathsToReload(from: items.count)
            view?.loadNextPage(indexPath: indexPaths)
        } else {
            // For offline mode, the app saves only the firt page
            do {
                try codableStorage.store(items, as: "user.sessionId")
            } catch let error {
                print(error.localizedDescription)
            }
            view?.loadFirstPage()
        }
    }

    func viewModels(from resultResponse: [ResultResponse]) -> [PosterViewModel] {
        return resultResponse.map { mapViewModel(from: $0) }
    }

    func mapViewModel(from resultResponse: ResultResponse) -> PosterViewModel {
        return .init(movieIdentifier: resultResponse.id.description,
                     imageURLPath: resultResponse.posterPath ?? "",
                     name: resultResponse.title ?? "",
                     date: resultResponse.releaseDate ?? "",
                     language: "Language: \(resultResponse.originalLanguage)")
    }

    func calculateIndexPathsToReload(from newElementsTotal: Int) -> [IndexPath] {
      let startIndex = elements.count - newElementsTotal
      let endIndex = startIndex + newElementsTotal
      return (startIndex..<endIndex).map({ IndexPath(row: $0, section: 0) })
    }

     func updateTotalIfNeeded(totalResults: Int) {
        if total == 0 {
            total = totalResults
        }
    }

    func handleError(_ error: Error) {
        isFeching = false
        view?.showError(with: .init(title: "Error",
                                    message: error.localizedDescription,
                                    primaryButton: "Ok"))

    }
}
