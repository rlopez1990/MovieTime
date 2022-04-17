//
//  UIAlertController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import UIKit

extension UIAlertController {

    convenience init(viewModel: AlertViewModel) {
        self.init(title: viewModel.title, message: viewModel.message, preferredStyle: viewModel.preferredStyle)
    }

    func setUp(actionTitle: String) {
        addAction(UIAlertAction(title: actionTitle,
                                style: .default))
    }
}
