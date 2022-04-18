//
//  ImageCacheTests.swift
//  MovieTimeTests
//
//  Created by Raul Lopez Martinez on 18/04/22.
//

import XCTest
@testable import MovieTime

class ImageCacheTests: XCTestCase {

    var clientMock = HTTPClientMock()
    var imageCache: ImageCache!
    let firstImage = UIImage(systemName: "phone")!
    let secondImage = UIImage(systemName: "display")!
    let placeHolderImage = UIImage(systemName: "clock")!

    override func setUpWithError() throws {
        imageCache = ImageCache(httpCliente: clientMock)
    }

    func testloadPosterImageWithValidImageFromClient() throws {
        let expectation = XCTestExpectation(description: #function)
        var finalImage: UIImage?
        // Given
        clientMock.imageMock = firstImage
        // When
        imageCache.loadPosterImage(path: "dummy",
                                   imageQualityType: .low,
                                   placeholderImage: placeHolderImage,
                                   loadedImage: { posterImage in
            finalImage = posterImage
            expectation.fulfill()
        })
        // Then
        XCTWaiter().wait(for: [expectation], timeout: 1.0)
        guard let posterImage = finalImage else {
            return XCTFail("There should be an image")
        }
        XCTAssertEqual(posterImage, firstImage, "Images should be equal")
    }

    func testloadPosterImageWithInvalidImageFromClient() throws {
        let expectation = XCTestExpectation(description: #function)
        var finalImage: UIImage?
        // Given
        clientMock.imageMock = nil
        // When
        imageCache.loadPosterImage(path: "dummy",
                                   imageQualityType: .low,
                                   placeholderImage: placeHolderImage,
                                   loadedImage: { posterImage in
            finalImage = posterImage
            expectation.fulfill()
        })
        // Then
        XCTWaiter().wait(for: [expectation], timeout: 1.0)
        guard let posterImage = finalImage else {
            return XCTFail("There should be an image")
        }
        XCTAssertEqual(posterImage, placeHolderImage, "Images should be equal")
    }


    func testValidCacheImage() throws {
        let path = "local"
        let expectation = XCTestExpectation(description: #function)
        var finalImage: UIImage?

        // When
        clientMock.imageMock = firstImage
        imageCache.loadPosterImage(path: path,
                                   imageQualityType: .low,
                                   placeholderImage: UIImage(systemName: "clock")!,
                                   loadedImage: { posterImage in })
        clientMock.imageMock = secondImage
        imageCache.loadPosterImage(path: path,
                                   imageQualityType: .low,
                                   placeholderImage: UIImage(systemName: "clock")!,
                                   loadedImage: { posterImage in
            finalImage = posterImage
            expectation.fulfill()
        })
        // Then
        XCTWaiter().wait(for: [expectation], timeout: 1.0)
        guard let posterImage = finalImage else {
            return XCTFail("There should be an image")
        }
        XCTAssertEqual(posterImage, firstImage, "Images should be equal to the fist image")
    }

}
