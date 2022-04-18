//
//  MenuViewControllerMock.swift
//  MovieTimeTests
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import UIKit
@testable import MovieTime

final class MenuViewControllerMock: MenuConfigurable {
    var newViewControllersMock: [UIViewController]?
    
    func updateTabBarController(wirh viewControllers: [UIViewController]) {
        newViewControllersMock = viewControllers
    }
}
