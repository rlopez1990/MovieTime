//
//  MenuViewController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

final class MenuViewController: UITabBarController {

    lazy var presenter: MenuPresentable = MenuPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setupController()
    }
}
