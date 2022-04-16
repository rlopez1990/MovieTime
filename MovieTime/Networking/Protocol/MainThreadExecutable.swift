//
//  MainThreadExecutable.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 15/04/22.
//

import Foundation

protocol MainThreadExecutable {
    func completionOnMainThread<Arg>(completion: @escaping (Arg) -> Void) -> ((Arg) -> Void)
}

extension MainThreadExecutable {
    /// Complete the proccess on Main Thread
    /// - Parameter completion: Closure
    func completionOnMainThread<Arg>(completion: @escaping (Arg) -> Void) -> ((Arg) -> Void) {
        return { arg in
            DispatchQueue.main.async {
                completion(arg)
            }
        }
    }
}
