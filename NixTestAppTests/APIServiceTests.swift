//
//  APIServiceTests.swift
//  NixTestAppTests
//
//  Created by Dim on 12.01.2025.
//

import XCTest
@testable import NixTestApp

final class APIServiceTests: XCTestCase {
    var apiService: APIService!
    var mockRepository: MockHTTPRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockHTTPRepository()
        apiService = APIService(httpRepository: mockRepository)
    }

    override func tearDown() {
        apiService = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchCarsSuccess() async throws {
        // Arrange
        let cars = [
            Car(id: 1, make: "Toyota", model: "Corolla", price: 15000, firstRegistration: nil, mileage: 20000, fuel: "Gasoline", images: nil, description: "", modelline: nil, seller: nil, colour: "")
        ]
        let mockData = try JSONEncoder().encode(cars)
        mockRepository.result = .success(mockData)

        // Act
        let fetchedCars = try await apiService.fetchCars()

        // Assert
        XCTAssertEqual(fetchedCars.count, 1)
        XCTAssertEqual(fetchedCars.first?.make, "Toyota")
    }

    func testFetchCarsFailure() async {
        // Arrange
        mockRepository.result = .failure(APIErrors.invalidURL)

        // Act & Assert
        do {
            _ = try await apiService.fetchCars()
            XCTFail("Expected to throw, but no error was thrown.")
        } catch {
            XCTAssertEqual(error as? APIErrors, APIErrors.invalidURL)
        }
    }
}
