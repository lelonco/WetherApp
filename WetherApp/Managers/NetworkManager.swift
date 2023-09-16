//
//  NetworkManager.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import Foundation


class NetworkManager {
    enum Errors: Error {
        case invalidURL
        case networkError(error: Error)
        case decodeError(error: Error)
        case missingReqParameters
    }

    
    class func fetch<T: Decodable>(request: URL, decodeTo: T.Type) async throws -> T {
        let request = URLRequest(url: request)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
             
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let value = try decoder.decode(T.self, from: data)
            
            return value
        } catch {
            switch error {
            case is DecodingError:
                throw Errors.decodeError(error: error)
            default:
                throw Errors.networkError(error: error)
            }
        }
    }
}
