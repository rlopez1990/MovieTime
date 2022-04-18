//
//  NavigationControllerMock.swift
//  MovieTimeTests
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import UIKit

final class NavigationControllerMock: UINavigationController {

    var pushedViewControllerMock: UIViewController?
    var presentedViewControllerMock: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllerMock = viewController
    }

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedViewControllerMock =  viewControllerToPresent
    }
}
