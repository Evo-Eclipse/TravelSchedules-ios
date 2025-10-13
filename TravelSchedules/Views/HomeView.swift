//
//  HomeView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct HomeView: View {
    @Environment(TripSelection.self) private var tripSelection
    @Environment(AppNavigator.self) private var appNavigator
    
    private let dependencies = DIContainer.shared
    
    var isFormComplete: Bool {
        tripSelection.isComplete
    }
    
    var body: some View {
        @Bindable var navigator = appNavigator
        NavigationStack(path: $navigator.path) {
            ZStack {
                Color.yWhite
                    .ignoresSafeArea()
                
                VStack {
                    // Stories placeholder
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<5) { index in
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.yGrayLight)
                                    .frame(width: 92, height: 140)
                            }
                        }
                        .padding()
                    }
                    
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 0) {
                            Button {
                                navigator.push(.cityPicker(.from))
                            } label: {
                                Text(tripSelection.fromStation?.title ?? "Откуда")
                                    .lineLimit(1)
                                    .foregroundColor(tripSelection.fromStation == nil ? .yGrayUniversal : .yBlackUniversal)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Button {
                                navigator.push(.cityPicker(.to))
                            } label: {
                                Text(tripSelection.toStation?.title ?? "Куда")
                                    .lineLimit(1)
                                    .foregroundColor(tripSelection.toStation == nil ? .yGrayUniversal : .yBlackUniversal)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .background(Color.yWhiteUniversal)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Button {
                            tripSelection.swapDirections()
                        } label: {
                            Image(systemName: "arrow.2.squarepath")
                                .foregroundColor(.yBlue)
                                .padding()
                                .background(Color.yWhiteUniversal)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.yBlue)
                    )
                    .padding()
                    
                    if isFormComplete {
                        Button {
                            if let from = tripSelection.fromStation, let to = tripSelection.toStation {
                                navigator.push(.schedules(from: from, to: to))
                            }
                        } label: {
                            Text("Найти")
                                .bold()
                                .foregroundColor(.yWhiteUniversal)
                                .frame(minWidth: 60)
                                .padding(20)
                                .background(Color.yBlue)
                                .cornerRadius(16)
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationDestination(for: AppRoute.self) { destination in
                switch destination {
                case .cityPicker(let direction):
                    CityPickerView(
                        viewModel: dependencies.makeCityPickerViewModel(),
                        direction: direction
                    )
                case .stationPicker(let city, let direction):
                    StationPickerView(
                        viewModel: dependencies.makeStationPickerViewModel(),
                        city: city,
                        direction: direction
                    )
                case .schedules(let from, let to):
                    SchedulesView(
                        viewModel: dependencies.makeSchedulesViewModel(),
                        fromStation: from,
                        toStation: to
                    )
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
