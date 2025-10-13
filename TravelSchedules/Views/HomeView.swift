//
//  HomeView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var fromCity: City?
    @State private var fromStation: Station?
    @State private var toCity: City?
    @State private var toStation: Station?
    
    @State private var showFromCityPicker = false
    @State private var showToCityPicker = false
    @State private var showFromStationPicker = false
    @State private var showToStationPicker = false

    @State private var navigateToSchedules = false
    
    private let dependencies = DIContainer.shared
    
    var isFormComplete: Bool {
        fromCity != nil && fromStation != nil && toCity != nil && toStation != nil
    }
    
    var body: some View {
        NavigationStack {
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
                                showFromCityPicker = true
                            } label: {
                                Text(fromStation?.title ?? "Откуда")
                                    .lineLimit(1)
                                    .foregroundColor(fromStation == nil ? .yGrayUniversal : .yBlackUniversal)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Button {
                                showToCityPicker = true
                            } label: {
                                Text(toStation?.title ?? "Куда")
                                    .lineLimit(1)
                                    .foregroundColor(toStation == nil ? .yGrayUniversal : .yBlackUniversal)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .background(Color.yWhiteUniversal)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Button {
                            swap(&fromCity, &toCity)
                            swap(&fromStation, &toStation)
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
                            navigateToSchedules = true
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
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $showFromCityPicker) {
            CityPickerView(
                viewModel: dependencies.makeCityPickerViewModel()
            ) { city in
                fromCity = city
                showFromCityPicker = false
                showFromStationPicker = true
            }
        }
        .fullScreenCover(isPresented: $showToCityPicker) {
            CityPickerView(
                viewModel: dependencies.makeCityPickerViewModel()
            ) { city in
                toCity = city
                showToCityPicker = false
                showToStationPicker = true
            }
        }
        .fullScreenCover(isPresented: $showFromStationPicker) {
            if let city = fromCity {
                StationPickerView(
                    viewModel: dependencies.makeStationPickerViewModel(),
                    cityCode: city.code
                ) { station in
                    fromStation = station
                    showFromStationPicker = false
                }
            }
        }
        .fullScreenCover(isPresented: $showToStationPicker) {
            if let city = toCity {
                StationPickerView(
                    viewModel: dependencies.makeStationPickerViewModel(),
                    cityCode: city.code
                ) { station in
                    toStation = station
                    showToStationPicker = false
                }
            }
        }
        .fullScreenCover(isPresented: $navigateToSchedules) {
            if let fromStation, let toStation {
                SchedulesView(
                    viewModel: dependencies.makeSchedulesViewModel(),
                    fromStation: fromStation,
                    toStation: toStation
                )
            }
        }
    }
}

#Preview {
    HomeView()
}
