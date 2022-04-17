//
//  SearchMoviePresenter.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import UIKit

protocol SearchPresentable: ListPressentable {
    func fetchData(with word: String)
}

final class SearchMoviePresenter {
    var elements: [PosterViewModel] = []
    var total = 0
    var page = 1
    var viewCoordinator: ViewCoordinator


    // MARK: - Private properties
    internal weak var view: ListMoviesDisplayable?
    private var dataService: MovieDatabaseService
    private var isFeching = false
    
    init(view: ListMoviesDisplayable?,
         dataService: MovieDatabaseService = MovieDatabaseService(),
         viewCoordinator: ViewCoordinator = ViewCoordinator()) {
        self.view = view
        self.dataService = dataService
        self.viewCoordinator = viewCoordinator
    }
}

extension SearchMoviePresenter: SearchPresentable {

    func fetchData(with word: String) {
        guard !isFeching else { return }

        isFeching = true
        dataService.searchMovies(word: word, page: page) { [weak self] result in
            switch result {
            case.success(let movieResponse):
                self?.handleResponse(movieResponse: movieResponse)
            case .failure:
                // TODO: Show Error
                print("SWW")
            }
        }
    }

    func setupController() {
        let viewModel = TableViewModel(allowSelection: true,
                                       cellHeight: UITableView.automaticDimension,
                                       separatorStyle: .singleLine)
        view?.setupTable(viewModel: viewModel)
    }

    func gotToDetail(row: Int, navigationController: UINavigationController?) {
        let movieIdentifier = elements[row].movieIdentifier
        viewCoordinator.goDetails(for: movieIdentifier,
                                     navigationController: navigationController)
    }
}


private extension SearchMoviePresenter {

    func handleResponse(movieResponse: MoviesResponse) {
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
                     language: resultResponse.originalLanguage)
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
}
