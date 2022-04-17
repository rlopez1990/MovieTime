//
//  LoaderDisplayable.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import UIKit

/// Protocol used by viewControllers
protocol LoaderDisplayable: AnyObject {
    var loader: LoadingViewProtocol { get }

    func showLoader()
    func dissmissLoader()
    func showError(with alerViewModel: AlertViewModel)
}

extension LoaderDisplayable where Self: UIViewController {
    func showLoader() {
        loader.addLoadingView(onView: view)
    }

    func dissmissLoader() {
        loader.removeLoadingView()
    }

    func showError(with alerViewModel: AlertViewModel) {
        let alertController = UIAlertController(viewModel: alerViewModel)
        alertController.setUp(actionTitle: alerViewModel.primaryButton)
        navigationController?.present(alertController, animated: true)
    }
}
