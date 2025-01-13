//
//  CarsListViewModel.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import Foundation
import Combine

enum FetchError: LocalizedError {
    case networkError
    case decodingError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network error occurred. Please try again."
        case .decodingError:
            return "Failed to decode the data."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

final class CarsListViewModel: ObservableObject {
    @Published var cars: [Car] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var sortAscending: Bool = true
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    var sortedCars: [Car] {
        cars.sorted { sortAscending ? $0.price < $1.price : $0.price > $1.price }
    }
       
    func toggleSorting() {
        sortAscending.toggle()
    }
    
    @MainActor
    func fetchTransactions() async {
        isLoading = true
        errorMessage = nil
        do {
            cars = try await apiService.fetchCars()
        } catch let error as FetchError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = FetchError.unknownError.errorDescription
        }
        isLoading = false
    }
}
