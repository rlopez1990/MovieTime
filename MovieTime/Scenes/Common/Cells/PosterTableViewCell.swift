//
//  PosterTableViewCell.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

final class PosterTableViewCell: UITableViewCell, UITableViewCellRegistrable {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    let imageCache: ImageCache = ImageCache.instance

    func setup(viewModel: PosterViewModel) {
        movieTitleLabel.text = viewModel.name
        yearLabel.text = viewModel.date
        genreLabel.text = viewModel.language
        if let placeHolder =  UIImage(named: "PlaceHolder") {
            imageCache.loadPosterImage(path: viewModel.imageURLPath,
                                       placeholderImage: placeHolder) { [weak self] image in
                self?.posterImageView.image = image
            }
        }
    }
    
}
