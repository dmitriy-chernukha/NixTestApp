//
//  NixTestAppApp.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import SwiftUI

@main
struct NixTestAppApp: App {
    
    private let apiService = APIService(httpRepository: HTTPRepository())
    
    var body: some Scene {
        WindowGroup {
            let viewModel = CarsListViewModel(apiService: apiService)
            CarsListView(viewModel: viewModel)
        }
    }
}
