//
//  NetworkReachabilityMock.swift
//  MovieTimeTests
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import Foundation
@testable import MovieTime

final class NetworkReachabilityMock: Conectable {

    var isConnected = true

    func checkConnection() -> Bool {
        return isConnected
    }
}
