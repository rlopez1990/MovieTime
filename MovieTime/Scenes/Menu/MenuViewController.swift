//
//  MenuViewController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

protocol MenuConfigurable: AnyObject {
    func updateTabBarController(wirh viewControllers: [UIViewController])
}

final class MenuViewController: UITabBarController {

    lazy var presenter: MenuPresentable = MenuPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setupController()
    }
}

extension MenuViewController: MenuConfigurable {
    func updateTabBarController(wirh viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}
