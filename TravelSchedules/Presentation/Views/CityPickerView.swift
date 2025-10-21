//
//  CityPickerView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct CityPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(TripSelection.self) private var tripSelection
    @Environment(AppNavigator.self) private var navigator
    @State var viewModel: CityPickerViewModel
    let direction: Direction
    
    var body: some View {
        ZStack {
            Color.yWhite
                .ignoresSafeArea()
            
            VStack {
                SearchBarView(searchText: $viewModel.searchQuery)
                
                switch viewModel.state {
                case .idle:
                    EmptyView()
                    
                case .loading:
                    Spacer()
                    ProgressView()
                    Spacer()
                    
                case .loaded:
                    if viewModel.filteredCities.isEmpty && !viewModel.searchQuery.isEmpty {
                        Spacer()
                        Text("Город не найден")
                            .font(.title)
                            .bold()
                            .foregroundColor(.yBlack)
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.filteredCities, id: \.code) { city in
                                    Button {
                                        selectCity(city)
                                    } label: {
                                        ListCellView(title: city.title)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    
                case .error(let errorType):
                    ErrorView(type: errorType == .network ? .noInternet : .serverError)
                }
            }
        }
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .customBackButton(dismiss: dismiss)
        .task {
            await viewModel.loadCities()
        }
    }

    private func selectCity(_ city: City) {
        switch direction {
        case .from:
            tripSelection.fromCity = city
            tripSelection.fromStation = nil
        case .to:
            tripSelection.toCity = city
            tripSelection.toStation = nil
        }
        navigator.push(.stationPicker(city: city, direction: direction))
    }
}

#Preview {
    CityPickerView(
        viewModel: DIContainer.shared.makeCityPickerViewModel(),
        direction: .from
    )
}
