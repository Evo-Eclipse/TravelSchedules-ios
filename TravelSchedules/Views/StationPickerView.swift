//
//  StationPickerView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct StationPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(TripSelection.self) private var tripSelection
    @Environment(AppNavigator.self) private var navigator
    @State var viewModel: StationPickerViewModel
    let city: City
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
                    if viewModel.filteredStations.isEmpty && !viewModel.searchQuery.isEmpty {
                        Spacer()
                        Text("Станция не найдена")
                            .font(.title)
                            .bold()
                            .foregroundColor(.yBlack)
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.filteredStations, id: \.code) { station in
                                    Button {
                                        selectStation(station)
                                    } label: {
                                        ListCellView(title: station.title)
                                    }
                                }
                            }
                        }
                    }
                    
                case .error(let errorType):
                    ErrorView(type: errorType == .network ? .noInternet : .serverError)
                }
            }
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .customBackButton(dismiss: dismiss)
        .task {
            await viewModel.loadStations(cityCode: city.code)
        }
    }

    private func selectStation(_ station: Station) {
        switch direction {
        case .from:
            tripSelection.fromStation = station
        case .to:
            tripSelection.toStation = station
        }
        navigator.pop(2)
    }
}

#Preview {
    StationPickerView(
        viewModel: DIContainer.shared.makeStationPickerViewModel(),
        city: City(code: "c213", title: "Москва", lat: nil, lng: nil, distanceKm: nil, kind: .settlement),
        direction: .from
    )
}
