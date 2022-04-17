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
    struct Option {
        let title: String
        let image: UIImage?
        let selectedImage: UIImage?
        let viewController: UIViewController.Type
        let searchType: SearchType
    }

    private weak var view: MenuViewController?
    private let options = [Option(title: "Popular",
                                  image: UIImage(systemName: "film"),
                                  selectedImage: UIImage(systemName: "film.fill"),
                                  viewController: PopularTableViewController.self,
                                  searchType: .popular),
                            Option(title: "Top Rated",
                                   image: UIImage(systemName: "tv"),
                                   selectedImage: UIImage(systemName: "tv.fill"),
                                   viewController: PopularTableViewController.self,
                                   searchType: .topRated),
                            Option(title: "Upcoming",
                                   image: UIImage(systemName: "play.tv"),
                                   selectedImage: UIImage(systemName: "play.tv.fill"),
                                   viewController: PopularTableViewController.self,
                                   searchType: .upcoming),
                            Option(title: "Search",
                                   image: UIImage(systemName: "magnifyingglass"),
                                   selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"),
                                   viewController: SearchMovieTableViewController.self,
                                   searchType: .popular)]

    init(view: MenuViewController?) {
        self.view = view
    }
}

extension MenuPresenter: MenuPresentable {
    func setupController() {
        // Create Tab one
        self.view?.viewControllers = options.map { viewController(for: $0) }
    }
}

// MARK: - Private methods
private extension MenuPresenter {

    func viewController(for option: Option) -> UIViewController {
        let viewController = option.viewController.init()

        if let popular = viewController as? PopularTableViewController {
            popular.searchType = option.searchType
        }
        viewController.navigationItem.title = option.title
        viewController.tabBarItem = barItem(for: option)
        return UINavigationController(rootViewController: viewController)
    }

    func barItem(for option: Option) -> UITabBarItem {
        return .init(title: option.title,
                     image: option.image,
                     selectedImage: option.selectedImage)
    }
}
