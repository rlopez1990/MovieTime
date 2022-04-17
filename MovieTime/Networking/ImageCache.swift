//
//  ImageCache.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 15/04/22.
//

import Foundation
import UIKit

final class ImageCache: MainThreadExecutable {

    private enum Constants {
        static let baseURL = "https://image.tmdb.org"
    }

    private static var httpClient: HTTPClient = {
        let urlSession = URLSession(configuration: .default,
                                    delegate: nil,
                                    delegateQueue: nil)
        return URLSessionHTTPClient(baseURL: Constants.baseURL, urlSession: urlSession)
    }()

    static let instance = ImageCache()

    // MARK: - Private properties
    private var imageCache = NSCache<NSString, UIImage>()
    private let httpClient: HTTPClient

    // MARK: - Initializer
    init(httpCliente: HTTPClient = ImageCache.httpClient) {
        self.httpClient = httpCliente
    }

    func loadPosterImage(path: String, imageQualityType: ImageQualityType, placeholderImage: UIImage, loadedImage: @escaping (UIImage) -> Void) {
        let identifier = imageQualityType.rawValue + path
        if let cachedImage = imageCache.object(forKey: identifier as NSString) {
            loadedImage(cachedImage)
        } else {
            let mainThread = completionOnMainThread(completion: loadedImage)
            httpClient.fetchImage(path: path, quality: imageQualityType) { image in
                if let validImage = image {
                    mainThread(validImage)
                } else {
                    mainThread(placeholderImage)
                }
            }
        }
    }
}
