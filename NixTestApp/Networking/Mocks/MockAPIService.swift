//
//  MockAPIService.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import Foundation

final class MockAPIService: APIServiceProtocol {
    var result: Result<[Car], Error> = .success([])

    func fetchCars() async throws -> [Car] {
        switch result {
        case .success(let cars):
            return cars
        case .failure(let error):
            throw error
        }
    }
}
