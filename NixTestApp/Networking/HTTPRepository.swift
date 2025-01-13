//
//  HTTPRepository.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import Foundation

protocol HTTPRepositoryProtocol: Sendable {
    func fetch<T: Decodable>(endpoint: Endpoints) async throws -> T
}

final class HTTPRepository: HTTPRepositoryProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    private func makeRequest(endpoint: Endpoints) throws -> URLRequest {
        guard let url = endpoint.url else {
            throw APIErrors.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers

        if !endpoint.queryParameters.isEmpty {
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                throw APIErrors.invalidURL
            }
            components.queryItems = endpoint.queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            request.url = components.url
        }

        return request
    }
    
    func fetch<T: Decodable>(endpoint: Endpoints) async throws -> T {
        let request = try makeRequest(endpoint: endpoint)
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIErrors.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
            }
            
            let decoder = JSONDecoder()
            
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw APIErrors.decodingError
        }
    }
}
