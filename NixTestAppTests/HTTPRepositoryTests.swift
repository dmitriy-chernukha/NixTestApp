//
//  HTTPRepositoryTests.swift
//  NixTestAppTests
//
//  Created by Dim on 12.01.2025.
//

import XCTest
@testable import NixTestApp

final class HTTPRepositoryTests: XCTestCase {
    var repository: HTTPRepository!
    var session: URLSession!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        repository = HTTPRepository(urlSession: session)
    }

    override func tearDown() {
        repository = nil
        session = nil
        super.tearDown()
    }

    func testFetchSuccess() async throws {
        // Arrange
        let cars = [Car(id: 1, make: "Toyota", model: "Corolla", price: 15000, firstRegistration: nil, mileage: 20000, fuel: "Gasoline", images: nil, description: "", modelline: nil, seller: nil, colour: nil)]
        MockURLProtocol.responseData = try JSONEncoder().encode(cars)
        MockURLProtocol.responseStatusCode = 200

        // Act
        let fetchedCars: [Car] = try await repository.fetch(endpoint: .cars)

        // Assert
        XCTAssertEqual(fetchedCars.count, 1)
        XCTAssertEqual(fetchedCars.first?.make, "Toyota")
    }
}
