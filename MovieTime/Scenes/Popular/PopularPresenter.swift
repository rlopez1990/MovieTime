//
//  PopularPresenter.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

protocol PopularPresentable {
    var elements: [PosterViewModel] { get }
    var total: Int { get }

    func setupController()
    func fetchData(from searchType: SearchType)
    func shouldShowLoadingCell(for indexPath: IndexPath) -> Bool
    func visibleIndexPaths(in tableView: UITableView, intersecting indexPaths: [IndexPath]) -> [IndexPath]
}

final class PopularPresenter {
    var elements: [PosterViewModel] = []
    var total = 0

    // MARK: - Private properties
    private weak var view: PopularMoviesDisplayable?
    private var dataService: MovieDatabaseService
    private var page = 1
    private var isFeching = false

    init(view: PopularMoviesDisplayable?,
         dataService: MovieDatabaseService = MovieDatabaseService()) {
        self.view = view
        self.dataService = dataService
    }
}

extension PopularPresenter: PopularPresentable {
    func setupController() {
        let viewModel = TableViewModel(allowSelection: true,
                                       cellHeight: UITableView.automaticDimension,
                                       separatorStyle: .singleLine)
        view?.setupTable(viewModel: viewModel)
    }

    func fetchData(from searchType: SearchType) {
        guard !isFeching else { return }

        isFeching = true
        dataService.getMovies(from: searchType, page: page) { [weak self] result in
            switch result {
            case.success(let movieResponse):
                self?.handleResponse(movieResponse: movieResponse)
            case .failure:
                // TODO: Show Error
                print("SWW")
            }
        }
    }

    func shouldShowLoadingCell(for indexPath: IndexPath) -> Bool {
      return indexPath.row >= elements.count
    }

    func visibleIndexPaths(in tableView: UITableView, intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

// MARK: - Private methods
private extension PopularPresenter {

    func handleResponse(movieResponse: MoviesResponse) {
        view?.dissmissLoader()

        page += 1
        isFeching = false
        updateTotalIfNeeded(totalResults: movieResponse.totalResults)

        let items = viewModels(from: movieResponse.results)
        elements.append(contentsOf: items)

        if movieResponse.page > 1 {
            let indexPaths = calculateIndexPathsToReload(from: items)
            view?.loadNextPage(indexPath: indexPaths)
        } else {
            view?.loadFirstPage()
        }
    }

    func viewModels(from resultResponse: [ResultResponse]) -> [PosterViewModel] {
        return resultResponse.map { mapViewModel(from: $0) }
    }

    func mapViewModel(from resultResponse: ResultResponse) -> PosterViewModel {
        return .init(imageURLPath: resultResponse.posterPath ?? "",
                     name: resultResponse.title ?? "",
                     date: resultResponse.releaseDate ?? "",
                     language: resultResponse.originalLanguage)
    }

    private func calculateIndexPathsToReload(from viewModels: [PosterViewModel]) -> [IndexPath] {
      let startIndex = elements.count - viewModels.count
      let endIndex = startIndex + viewModels.count
      return (startIndex..<endIndex).map({ IndexPath(row: $0, section: 0) })
    }

    private func updateTotalIfNeeded(totalResults: Int) {
        if total == 0 {
            total = totalResults
        }
    }

}
