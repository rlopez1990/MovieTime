//
//  HTTPClientMock.swift
//  MovieTimeTests
//
//  Created by Raul Lopez Martinez on 18/04/22.
//

import UIKit
@testable import MovieTime

final class HTTPClientMock: HTTPClient {

    var imageMock: UIImage?

    func execute<Request: HTTPRequestable>(request: Request,
                                           completion: @escaping (HTTPResponse<Request.Response>) -> Void) {

    }

    func fetchImage(path: String, quality: ImageQualityType, completion: @escaping (UIImage?) -> Void) {
        completion(imageMock)
    }
}
