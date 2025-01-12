//
//  CarsListViewModel.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import Foundation
import Combine

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
        do {
            cars = try await apiService.fetchCars()
        } catch {
            errorMessage = error.localizedDescription
        }
        self.isLoading = false
    }
}
