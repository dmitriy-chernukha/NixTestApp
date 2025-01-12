//
//  APIErrors.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import Foundation

enum APIErrors: Error, Equatable {
    case invalidURL
    case decodingError
    case serverError(statusCode: Int)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "errorInvalidUrl"
        case .decodingError:
            return "errorDecoding"
        case .serverError(let statusCode):
            return "errorServer" + "\(statusCode)."
        }
    }
}
