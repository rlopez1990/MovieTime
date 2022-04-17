//
//  MovieDetailViewController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import UIKit

struct DetailViewModel {
    let imagePath: String
    let dateString: String
    let movieTitle: String
    let rating: String
    let overview: String
    let productConpanies: String
}

protocol MoviesDetailDisplayable: LoaderDisplayable {
    func setupViewController(viewModel: DetailViewModel)
}

final class MovieDetailViewController: UIViewController, LoaderDisplayable {

    // MARK: - IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var productCompaniesLabel: UILabel!

    // MARK: - Public properties
    let imageCache: ImageCache = ImageCache.instance
    lazy var loader: LoadingViewProtocol = LoadingView()
    lazy var presenter: ProductDetailFetchable = MovieDetailPresenter(view: self)
    var movieIdentifier: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let movieIdentifier = movieIdentifier {
            presenter.fetchMovieDetail(for: movieIdentifier)
        }
    }
}

// MARK: - MovieDetailViewController implmentation
extension MovieDetailViewController: MoviesDetailDisplayable {
    func setupViewController(viewModel: DetailViewModel) {
        dateLabel.text = viewModel.dateString
        movieTitleLabel.text = viewModel.movieTitle
        movieOverView.text = viewModel.overview
        movieRating.text = viewModel.rating
        productCompaniesLabel.text = viewModel.productConpanies

        if let placeHolder =  UIImage(named: "PlaceHolder") {
            imageCache.loadPosterImage(path: viewModel.imagePath,
                                       imageQualityType: .hight,
                                       placeholderImage: placeHolder) { [weak self] image in
                self?.posterImageView.image = image
            }
        }
    }
}


