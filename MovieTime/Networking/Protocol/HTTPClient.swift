//
//  HTTPClient.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 12/04/22.
//

import Foundation
import UIKit

protocol HTTPClient: AnyObject {    
    func execute<Request: HTTPRequestable>(request: Request,
                                           completion: @escaping (HTTPResponse<Request.Response>) -> Void)

    func fetchImage(path: String, quality: ImageQuality, completion: @escaping (UIImage?) -> Void)
}
