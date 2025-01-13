//
//  Endpoints.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import Foundation

enum Endpoints: CaseIterable {
    static let baseURL = "http://private-fe87c-simpleclassifieds.apiary-mock.com"
    
    case cars
    
    var url: URL? {
        switch self {
        case .cars:
            return URL(string: Endpoints.baseURL + path)
        }
    }
    
    private var path: String {
        switch self {
        case .cars:
            return ""
        }
    }
    
    var method: String {
        switch self {
        case .cars:
            return "GET"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .cars:
            return ["Content-Type": "application/json"]
        }
    }
    
    var queryParameters: [String: String] {
        switch self {
        case .cars:
            return [:]
        }
        
    }
}
