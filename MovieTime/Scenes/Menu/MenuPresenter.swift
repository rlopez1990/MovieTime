//
//  MenuPresenter.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

protocol MenuPresentable {
    func setupController()
}

final class MenuPresenter {
    weak var view: MenuViewController?

    init(view: MenuViewController?) {
        self.view = view
    }
}

extension MenuPresenter: MenuPresentable {
    func setupController() {
        // Create Tab one
        let tabOne = PopularTableViewController()
        let tabOneBarItem = UITabBarItem(title: "Popular",
                                         image: UIImage(systemName: "film"),
                                         selectedImage: UIImage(systemName: "film.fill"))
        tabOne.tabBarItem = tabOneBarItem

        // Create Tab two
        let tabTwo = PopularTableViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Top Rated",
                                          image: UIImage(systemName: "tv"),
                                          selectedImage: UIImage(systemName: "tv.fill"))
        tabTwo.tabBarItem = tabTwoBarItem2

        // Create Tab two
        let tabThree = PopularTableViewController()
        let tabThreeItem = UITabBarItem(title: "Upcoming",
                                    image: UIImage(systemName: "play.tv"),
                                    selectedImage: UIImage(systemName: "play.tv.fill"))
        tabThree.tabBarItem = tabThreeItem

        self.view?.viewControllers = [tabOne, tabTwo, tabThree]
    }
}
