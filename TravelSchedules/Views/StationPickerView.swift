//
//  StationPickerView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct StationPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: StationPickerViewModel
    let cityCode: String
    var onStationSelected: (Station) -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.yWhite
                    .ignoresSafeArea()
                
                VStack {
                    SearchBarView(searchText: $viewModel.searchQuery)
                    
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.filteredStations, id: \.code) { station in
                                    Button {
                                        onStationSelected(station)
                                    } label: {
                                        ListCellView(title: station.title)
                                    }
                                }
                            }
                        }
                        .overlay {
                            if viewModel.filteredStations.isEmpty && !viewModel.searchQuery.isEmpty {
                                Text("Станция не найдена")
                                    .font(.title)
                                    .foregroundColor(.yBlack)

                                // Would be better to use
                                // ContentUnavailableView(
                                //     "Станция не найдена",
                                //     systemImage: "magnifyingglass",
                                //     description: Text("Попробуйте изменить запрос")
                                // )
                            }
                        }
                    }
                }
            }
            .navigationTitle("Выбор станции")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.yBlack)
                    }
                }
            }
        }
        .task {
            await viewModel.loadStations(cityCode: cityCode)
        }
        .onChange(of: viewModel.searchQuery) {
            Task {
                await viewModel.searchStations(cityCode: cityCode)
            }
        }
    }
}

#Preview {
    StationPickerView(
        viewModel: DIContainer.shared.makeStationPickerViewModel(),
        cityCode: "c213"
    ) { station in
        print("Selected station: \(station.title)")
    }
}
