//
//  PopularPresenter.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

protocol PopularPresentable {
    func setupController()
    func fetchData()
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

    func fetchData() {
        dataService.
    }
}

// MARK: - Private methods
private extension PopularPresenter {
    func viewModels(from resultResponse: [ResultResponse]) -> [PosterViewModel] {
        return []
    }

    func mapViewModel(from resultResponse: ResultResponse) -> PosterViewModel {
        return .init(imageURL: URL(string: "")!,
                     name: resultResponse.originalTitle,
                     year: resultResponse.releaseDate,
                     gender: resultResponse.originalLanguage)
    }
}
