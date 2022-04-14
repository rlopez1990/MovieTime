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

    func setup(viewModel: PosterViewModel) {
        movieTitleLabel.text = viewModel.name
        yearLabel.text = viewModel.year
        genreLabel.text = viewModel.gender
    }
    
}
