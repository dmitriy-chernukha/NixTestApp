//
//  MockHTTPRepository.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import Foundation

final class MockHTTPRepository: HTTPRepositoryProtocol {
    var result: Result<Data, Error> = .success(Data())

    func fetch<T: Decodable>(endpoint: Endpoints) async throws -> T {
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        case .failure(let error):
            throw error
        }
    }
}
