//
//  SearchMoviePresenter.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import UIKit

protocol SearchPresentable: ListPressentable {
    func fetchData(with word: String?)
}

final class SearchMoviePresenter {
    var elements: [PosterViewModel] = []
    var total = 0
    var totalPages = 1
    var page = 1
    var viewCoordinator: ViewCoordinator
    var currentWord = ""

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

    func fetchData(with word: String?) {
        guard !isFeching else { return }

        if word == nil && page >= totalPages {
            return
        }

        if page == 1 {
            view?.showLoader()
        }

        let validWord = word ?? currentWord
        isFeching = true
        dataService.searchMovies(word: validWord, page: page) { [weak self] result in
            switch result {
            case.success(let movieResponse):
                self?.handleResponse(movieResponse: movieResponse, newWord: word)
            case .failure(let error):
                self?.handleError(error)
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

    func handleResponse(movieResponse: MoviesResponse, newWord: String?) {
        view?.dissmissLoader()
        isFeching = false
        totalPages = movieResponse.totalPages
        updateTotalIfNeeded(totalResults: movieResponse.totalResults)
        let items = viewModels(from: movieResponse.results)

        if newWord == nil {
            page += 1
            elements.append(contentsOf: items)
        } else {
            page = 1
            elements = items
        }

        if movieResponse.page > 1 {
            let indexPaths = calculateIndexPathsToReload(from: items.count)
            view?.loadNextPage(indexPath: indexPaths)
        } else {
            if let validWord = newWord {
                currentWord = validWord
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

    func handleError(_ error: Error) {
        isFeching = false
        view?.showError(with: .init(title: "Error",
                                    message: error.localizedDescription,
                                    primaryButton: "Ok"))

    }
}
