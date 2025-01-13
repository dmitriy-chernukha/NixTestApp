//
//  CarsListViewModelTests.swift
//  NixTestAppTests
//
//  Created by Dim on 12.01.2025.
//

import XCTest
@testable import NixTestApp

final class CarsListViewModelTests: XCTestCase {
    var viewModel: CarsListViewModel!
    var mockService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        viewModel = CarsListViewModel(apiService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testSortingAscending() {
        // Arrange
        let cars = [
            Car(id: 1, make: "Toyota", model: "Corolla", price: 15000, firstRegistration: nil, mileage: 20000, fuel: "Gasoline", images: nil, description: "", modelline: nil, seller: nil, colour: ""),
            Car(id: 2, make: "Honda", model: "Civic", price: 12000, firstRegistration: nil, mileage: 15000, fuel: "Gasoline", images: nil, description: "", modelline: nil, seller: nil, colour: "")
        ]
        mockService.result = .success(cars)

        // Act
        viewModel.sortAscending = true
        viewModel.cars = cars

        // Assert
        XCTAssertEqual(viewModel.sortedCars.first?.id, 2) // Honda Civic should be first
    }

    func testSortingDescending() {
        // Arrange
        let cars = [
            Car(id: 1, make: "Toyota", model: "Corolla", price: 15000, firstRegistration: nil, mileage: 20000, fuel: "Gasoline", images: nil, description: "", modelline: nil, seller: nil, colour: ""),
            Car(id: 2, make: "Honda", model: "Civic", price: 12000, firstRegistration: nil, mileage: 15000, fuel: "Gasoline", images: nil, description: "", modelline: nil, seller: nil, colour: "")
        ]
        mockService.result = .success(cars)

        // Act
        viewModel.sortAscending = false
        viewModel.cars = cars

        // Assert
        XCTAssertEqual(viewModel.sortedCars.first?.id, 1) // Toyota Corolla should be first
    }
}
