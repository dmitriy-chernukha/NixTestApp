//
//  CarsListView.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import SwiftUI

struct CarsListView: View {
    @ObservedObject var viewModel: CarsListViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    LoadingView()
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                } else {
                    listView
                }
            }
            .refreshable {
                Task {
                    await viewModel.fetchTransactions()
                }
            }
            .task {
                if viewModel.cars.isEmpty {
                    Task {
                        await viewModel.fetchTransactions()
                    }
                }
            }
            .animation(.easeInOut, value: viewModel.isLoading)
            .navigationTitle("Cars")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.toggleSorting()
                    }) {
                        HStack {
                            Text("Sort")
                                .font(.headline)
                                .foregroundColor(.black)
                            Image(systemName: viewModel.sortAscending ? "arrow.up" : "arrow.down")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
        
        private func errorView(message: String) -> some View {
            VStack(spacing: 16) {
                Text(message)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Text("Error")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button(action: {
                Task {
                    await viewModel.fetchTransactions()
                }
            }) {
                HStack {
                    Text("Try reload data")
                        .font(.headline)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.primary)
                .cornerRadius(8)
            }
        }
        .padding()
    }
    
    private var listView: some View {
        List(viewModel.sortedCars, id: \.id) { car in
            CellView(car: car)
        }
    }
}

extension CarsListView {
    struct CellView: View {
        var car: Car
        let currencyFormatter = NumberFormatter(locale: .current)
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                if let images = car.images {
                    ImageCarousel(
                        images: images,
                        height: 200
                    )
                } else {
                    Image("no-img-placeholder")
                        .resizable()
                        .frame(height: 200)
                }
                
                HStack(spacing: 4){
                    Text("\(car.make) \(car.model)")
                        .font(.body)
                    Spacer()
                    Text(currencyFormatter.formattedAmount(car.price) ?? "")
                        .font(.body)
                }
                
                if let modelline = car.modelline {
                    CarInfoView(title: "modelline:", text: modelline)
                }
                
                CarInfoView(title: "Fuel:", text: car.fuel)

                if let colour = car.colour {
                    CarInfoView(title: "Colour:", text: colour)
                }

                if car.mileage > 0 {
                    CarInfoView(title: "Mileage:", text: "\(car.mileage)")
                }

                if let firstRegistration = car.firstRegistration {
                    CarInfoView(title: "First registration:", text: firstRegistration)
                }

                Text(car.description)
                    .font(.subheadline)

                if let seller = car.seller {
                    Text("Seller")
                        .font(.headline)
                    
                    Text("\(seller.type) **tel:** \(seller.phone) **city:** \(seller.city)")
                        .font(.subheadline)
                }
                
            }
            
        }
    }
}

extension CarsListView {
    
    struct CarInfoView: View {
        let title: String
        let text: String

        var body: some View {
            HStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text(text)
                    .font(.subheadline)
                Spacer()
            }
        }
    }
}
