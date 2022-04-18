//
//  MovieDetailPresenter.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import Foundation
import UIKit

protocol ProductDetailFetchable {
    func fetchMovieDetail(for movieId: String)
}

final class MovieDetailPresenter {
    weak var view: MoviesDetailDisplayable?

    // MARK: - Private properties
    private var dataService: MovieDatabaseService

    init(view: MoviesDetailDisplayable?,
         dataService: MovieDatabaseService = MovieDatabaseService(),
         viewCoordinator: ViewCoordinator = ViewCoordinator()) {
        self.view = view
        self.dataService = dataService
    }
}

// MARK: - ProductDetailFetchable implementation
extension MovieDetailPresenter: ProductDetailFetchable {
    func fetchMovieDetail(for movieId: String) {
        dataService.getMovieDetails(movieIdentifier: movieId) { [weak self] result in
            switch result {
            case.success(let detailResponse):
                self?.handleResponse(detailResponse: detailResponse)
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
}

private extension MovieDetailPresenter {
    func handleResponse(detailResponse: MovieDetailResponse) {
        let viewModel = createViewModel(from: detailResponse)
        view?.setupViewController(viewModel: viewModel)
    }

    func createViewModel(from detailResponse: MovieDetailResponse) -> DetailViewModel {
        var companies = detailResponse.productionCompanies.reduce("", { $0 + "\($1.name)," })
        companies.removeLast()
        return .init(imagePath: detailResponse.backdropPath,
                     dateString: detailResponse.releaseDate,
                     movieTitle: detailResponse.title,
                     rating: "(\(detailResponse.voteAverage)/10)",
                     overview: detailResponse.overview,
                     productConpanies: "Companies: \(companies)")
    }

    func handleError(_ error: Error) {
        view?.showError(with: .init(title: "Error",
                                    message: error.localizedDescription,
                                    primaryButton: "Ok"))

    }
    
}
