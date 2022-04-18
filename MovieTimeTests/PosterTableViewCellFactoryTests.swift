//
//  PosterTableViewCellFactoryTests.swift
//  MovieTimeTests
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import XCTest
@testable import MovieTime

class PosterTableViewCellFactoryTests: XCTestCase {

    var posterTableViewCellFactory: PosterTableViewCellFactory!
    let tableViewMock = UITableView()
    let indexPathMock = IndexPath()

    override func setUpWithError() throws {
        PosterTableViewCell.registerCell(into: tableViewMock)
        LoaderTableViewCell.registerCell(into: tableViewMock)
        posterTableViewCellFactory = PosterTableViewCellFactory(tableView: tableViewMock,
                                                                indexPath: indexPathMock)
    }

    func testPosterTableViewCell() throws {
        // Given
        let viewModelMock = PosterViewModel(movieIdentifier: "342",
                                            imageURLPath: "",
                                            name: "Dummy Name",
                                            date: "2011",
                                            language: "ES")
        // When
        guard let cell = posterTableViewCellFactory.posterTableViewCell(with: viewModelMock) as? PosterTableViewCell else {
            return XCTFail("Invalid cell Type")
        }
        // Then
        XCTAssertEqual(cell.movieTitleLabel.text, viewModelMock.name)
        XCTAssertEqual(cell.yearLabel.text, viewModelMock.date)
    }

    func testLoaderTableViewCell() throws {
        // When
        guard let _ = posterTableViewCellFactory.loaderTableViewCell() as? LoaderTableViewCell else {
            return XCTFail("Invalid cell Type")
        }
    }
    
}
