//
//  CityPickerView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct CityPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: CityPickerViewModel
    var onCitySelected: (City) -> Void
    
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
                                ForEach(viewModel.filteredCities, id: \.code) { city in
                                    Button {
                                        onCitySelected(city)
                                    } label: {
                                        ListCellView(title: city.title)
                                    }
                                }
                            }
                        }
                        .overlay {
                            if viewModel.filteredCities.isEmpty && !viewModel.searchQuery.isEmpty {
                                Text("Город не найден")
                                    .font(.title)
                                    .foregroundColor(.yBlack)

                                // Would be better to use
                                // ContentUnavailableView(
                                //     "Город не найден",
                                //     systemImage: "magnifyingglass",
                                //     description: Text("Попробуйте изменить запрос")
                                // )
                            }
                        }
                    }
                }
                .navigationTitle("Выбор города")
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
        }
        .task {
            await viewModel.loadCities()
        }
        .onChange(of: viewModel.searchQuery) {
            Task {
                await viewModel.searchCities()
            }
        }
    }
}

#Preview {
    CityPickerView(
        viewModel: DIContainer.shared.makeCityPickerViewModel()
    ) { city in
        print("Selected city: \(city.title)")
    }
}
