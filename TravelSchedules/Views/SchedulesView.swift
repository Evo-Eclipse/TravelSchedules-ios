//
//  SchedulesView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct SchedulesView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: SchedulesViewModel
    @State private var showFilters = false
    
    var fromStation: Station
    var toStation: Station

    var body: some View {
        ZStack {
            Color.yWhite
                .ignoresSafeArea()
            
            VStack {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if viewModel.errorMessage != nil {
                    Spacer()
                    ErrorView(type: .serverError)
                    Spacer()
                } else if viewModel.filteredSegments.isEmpty {
                    Spacer()
                    Text("Вариантов нет")
                        .font(.title)
                        .bold()
                        .foregroundColor(.yBlack)
                    Spacer()
                } else {
                    ScrollView {
                        Text("\(fromStation.title) → \(toStation.title)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.yBlack)
                            .padding()
                        
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.filteredSegments, id: \.id) { segment in
                                NavigationLink {
                                    CarrierView()
                                } label: {
                                    ScheduleCardView(segment: segment)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 80)
                    }
                }
            }
        }
        .customBackButton(dismiss: dismiss)
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.loadSchedules(from: fromStation.code, to: toStation.code)
        }
        .sheet(isPresented: $showFilters) {
            let filtersVM = viewModel.filtersViewModel
            FiltersView(viewModel: filtersVM) {
                viewModel.selectedTimeRanges = filtersVM.selectedTimeRanges
                viewModel.showWithTransfers = filtersVM.showWithTransfers
                viewModel.applyFilters()
                showFilters = false
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                let filtersVM = viewModel.filtersViewModel
                filtersVM.selectedTimeRanges = viewModel.selectedTimeRanges
                filtersVM.showWithTransfers = viewModel.showWithTransfers
                showFilters = true
            } label: {
                HStack(spacing: 4) {
                    Text("Уточнить время")
                        .bold()
                        .foregroundColor(.yWhiteUniversal)
                    if !viewModel.selectedTimeRanges.isEmpty || viewModel.showWithTransfers != nil {
                        Circle()
                            .fill(.yRed)
                            .frame(width: 8, height: 8)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color.yBlue)
                .cornerRadius(16)
            }
            .padding()
        }
    }
}

#Preview {
    let fromStation = Station(
        code: "s2006004", // Москва (Ленинградский вокзал)
        title: "Москва (Ленинградский вокзал)",
        cityCode: "c213", // Москва
        lat: nil,
        lng: nil,
        transportType: .train,
        stationType: .station,
        stationTypeName: nil,
        esrCode: nil,
        direction: nil,
        majority: nil,
        distanceKm: nil
    )
    
    let toStation = Station(
        code: "s9602494",
        title: "Санкт-Петербург (Московский вокзал)",
        cityCode: "c2", // Санкт-Петербург
        lat: nil,
        lng: nil,
        transportType: .train,
        stationType: .station,
        stationTypeName: nil,
        esrCode: nil,
        direction: nil,
        majority: nil,
        distanceKm: nil
    )
    
    SchedulesView(
        viewModel: DIContainer.shared.makeSchedulesViewModel(),
        fromStation: fromStation,
        toStation: toStation
    )
}
