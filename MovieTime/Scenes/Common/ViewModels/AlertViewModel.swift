//
//  AlertViewModel.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import UIKit

struct AlertViewModel {
    let title: String
    let message: String
    let primaryButton: String
    var preferredStyle: UIAlertController.Style = .alert
}
