//
//  ViewCoordinator.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import UIKit

struct ViewCoordinator {
    private var reachability: Conectable

    init(reachability: Conectable = NetworkReachability()) {
        self.reachability = reachability
    }

    func mainViewController() -> UIViewController {
        return MenuViewController()
    }

    func goDetails(for movieIdentifier: String, navigationController: UINavigationController?) {
        if reachability.checkConnection() {
            let detailViewController = MovieDetailViewController()
            detailViewController.movieIdentifier = movieIdentifier
            navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            let alertController = createNoConnectionAlertController()
            navigationController?.present(alertController, animated: true)
        }
    }
}

private extension ViewCoordinator {
    func createNoConnectionAlertController() -> UIAlertController {
        let viewModel = AlertViewModel(title: "No internet connection",
                                       message: "It's required internet to go to the next page",
                                       primaryButton: "Ok")

        let alertController = UIAlertController(viewModel: viewModel)
        alertController.setUp(actionTitle: viewModel.primaryButton)
        return alertController
    }
}
