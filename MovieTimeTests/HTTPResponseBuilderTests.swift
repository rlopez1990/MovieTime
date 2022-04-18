//
//  HTTPResponseBuilderTests.swift
//  MovieTimeTests
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import XCTest
@testable import MovieTime

class HTTPResponseBuilderTests: XCTestCase {

    let responseBuilder = HTTPResponseBuilder<MovieRequest>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testCreateSuccessfulResponse() throws {
        let movieResponseMock = MoviesResponse(page: 3, results: [], totalPages: 50, totalResults: 300)
        let expectedRequest = URLRequest(url: URL(string: "www.google.com")!)
        // Given
        responseBuilder.update(urlRequest: expectedRequest,
                               httpResponse: nil)

        // When
        let response = responseBuilder.createSuccessfulResponse(response: movieResponseMock)
        // Then
        XCTAssertNil(response.httpResponse, "Propery should be nil")
        XCTAssertEqual(response.urlRequest, expectedRequest)
        guard case .success(let response) = response.result else {
            return XCTFail("Invalid Error")
        }
        XCTAssertEqual(movieResponseMock.page, response.page)
        XCTAssertEqual(movieResponseMock.totalPages, response.totalPages)
    }

    func testFailureResponseWithBasicError() throws {
        // Given
        let expectedError = HTTPResponse<MovieTime.MoviesResponse>.Error.unknown
        // When
        let response = responseBuilder.creteFailureResponse(error: expectedError)
        // Then
        XCTAssertNil(response.httpResponse, "Propery should be nil")
        XCTAssertNil(response.urlRequest, "Property should be nil")
        guard case .failure = response.result else {
            return XCTFail("Invalid Error")
        }
    }

}
