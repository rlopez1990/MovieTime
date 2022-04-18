//
//  CodableStorage.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 17/04/22.
//

import Foundation

/// A helper class that allows to read/write Codable types from/to a file
final class CodableStorage {

    /// Enlist the error when managing files/directories
    enum FileError: Swift.Error {
        case directoryNotFound
        case fileNotFound
    }

    /// Returns URL constructed from specified directory
    func getURLInDirectory() throws -> URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileError.directoryNotFound
        }
        return url
    }

    /// Store an encodable struct to the specified directory on disk
    ///
    /// - Parameters:
    ///   - object: the encodable struct to store
    ///   - directory: where to store the struct
    ///   - fileName: what to name the file where the struct data will be stored
    func store<T: Encodable>(_ object: T, as fileName: String) throws {
        let url = try getURLInDirectory().appendingPathComponent(fileName)
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
        FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
    }

    /// Retrieve and convert a struct from a file on disk
    ///
    /// - Parameters:
    ///   - fileName: name of the file where struct data is stored
    ///   - directory: directory where struct data is stored
    ///   - type: struct type (i.e. PosterViewModel.self)
    /// - Returns: decoded struct model(s) of data
    func retrieve<T: Decodable>(_ fileName: String, as type: T.Type) throws -> T {
        let url = try getURLInDirectory().appendingPathComponent(fileName)
        guard let data = FileManager.default.contents(atPath: url.path) else {
            throw FileError.fileNotFound
        }
        let model = try JSONDecoder().decode(type, from: data)
        return model
    }

    /// Returns BOOL indicating whether file exists at specified directory with specified file name
    func fileExists(_ fileName: String) -> Bool {
        guard let url = try? getURLInDirectory().appendingPathComponent(fileName) else {
            return false
        }
        return FileManager.default.fileExists(atPath: url.path)
    }
}
