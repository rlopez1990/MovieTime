//
//  ViewCoordinator.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import UIKit

struct ViewCoordinator {

    func mainViewController() -> UIViewController {
        return MenuViewController()
    }

    func goDetails(for movieIdentifier: String, navigationController: UINavigationController?) {
        let detailViewController = MovieDetailViewController()
        detailViewController.movieIdentifier = movieIdentifier
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
