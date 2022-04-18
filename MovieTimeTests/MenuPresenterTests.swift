//
//  MenuPresenterTests.swift
//  MovieTimeTests
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import XCTest
@testable import MovieTime

class MenuPresenterTests: XCTestCase {

    let menuViewControllerMock = MenuViewControllerMock()
    var presenter: MenuPresenter!

    override func setUpWithError() throws {
        presenter = MenuPresenter(view: menuViewControllerMock)
    }

    func testSetupController() throws {
        // Given
        presenter.setupController()
        // Then
        let viewcontrollers = menuViewControllerMock.newViewControllersMock
        XCTAssertEqual(viewcontrollers?.count, 4, "There should be 4 elements")
    }
}
