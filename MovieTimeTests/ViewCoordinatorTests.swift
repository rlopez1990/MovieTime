//
//  ViewCoordinatorTests.swift
//  MovieTimeTests
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import XCTest
@testable import MovieTime

class ViewCoordinatorTests: XCTestCase {

    let networkReachability = NetworkReachabilityMock()
    let navigationControllerMock = NavigationControllerMock()
    var coordinator: ViewCoordinator!

    override func setUpWithError() throws {
        coordinator = ViewCoordinator(reachability: networkReachability)
    }

    func testMainViewController() throws {
        // When
        let viewController = coordinator.mainViewController()
        // Then
        XCTAssertTrue((viewController is MenuViewController), "ViewController should be a Menu")
    }

    func testGoDetailsWithConnection() throws {
        // Given
        networkReachability.isConnected = true
        // When
        coordinator.goDetails(for: "1234", navigationController: navigationControllerMock)
        //
        guard let expectedViewControler = navigationControllerMock.pushedViewControllerMock else {
            return XCTFail("There should be a viewcontroller")
        }
        XCTAssertTrue((expectedViewControler is MovieDetailViewController), "ViewController should be a Detail")
        XCTAssertNil(navigationControllerMock.presentedViewControllerMock)
    }

    func testGoDetailsWithoutConnection() throws {
        // Given
        networkReachability.isConnected = false
        // When
        coordinator.goDetails(for: "1234", navigationController: navigationControllerMock)
        //
        guard let expectedViewControler = navigationControllerMock.presentedViewControllerMock else {
            return XCTFail("There should be a viewcontroller")
        }
        XCTAssertTrue((expectedViewControler is UIAlertController), "ViewController should be an Alert")
        XCTAssertNil(navigationControllerMock.pushedViewControllerMock)
    }

}
