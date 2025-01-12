//
//  Car.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

struct Car: Codable, Identifiable {
    let id: Int
    let make, model: String
    let price: Int
    let firstRegistration: String?
    let mileage: Int
    let fuel: String
    let images: [CarImage]?
    let description: String
    let modelline: String?
    let seller: Seller?
    let colour: String?
}
