//
//  APIService.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

protocol APIServiceProtocol {
    func fetchCars() async throws -> [Car]
}

final class APIService: APIServiceProtocol {
    private let httpRepository: HTTPRepositoryProtocol
    
    init(httpRepository: HTTPRepositoryProtocol) {
        self.httpRepository = httpRepository
    }
    
    func fetchCars() async throws -> [Car] {
        try await httpRepository.fetch(endpoint: .cars)
    }
}

