//
//  PopularPresenter.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

protocol PopularPresentable {
    func setupController()
    func fetchData(from searchType: SearchType, page: Int)
}

final class PopularPresenter {
    // MARK: - Private properties
    private weak var view: PopularMoviesDisplayable?
    private var dataService: MovieDatabaseService

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

    func fetchData(from searchType: SearchType, page: Int) {
        dataService.getMovies(from: searchType, page: 1) { [weak self] result in
            switch result {
            case.success(let movieResponse):
                self?.handleResponse(movieResponse: movieResponse)
            case .failure:
                // TODO: Show Error
                print("SWW")
            }
        }
    }
}

// MARK: - Private methods
private extension PopularPresenter {

    func handleResponse(movieResponse: MoviesResponse) {
        view?.dissmissLoader()
        let items = viewModels(from: movieResponse.results)
        view?.loadData(items: items)
    }

    func viewModels(from resultResponse: [ResultResponse]) -> [PosterViewModel] {
        return resultResponse.map { mapViewModel(from: $0) }
    }

    func mapViewModel(from resultResponse: ResultResponse) -> PosterViewModel {
        return .init(imageURLPath: resultResponse.posterPath,
                     name: resultResponse.title,
                     date: resultResponse.releaseDate,
                     language: resultResponse.originalLanguage)
    }

}
