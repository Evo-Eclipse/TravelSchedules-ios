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
    @State private var selectedStoryIndex: Int?
    @State private var showStories = false
    @State private var storiesRefreshTrigger = UUID()
    
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
                
                VStack(spacing: 0) {
                    storiesCollection
                    directionPanel
                    Spacer()
                    searchButton
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
                case .carrierInfo(let carrier):
                    CarrierInfoView(carrier: carrier)
                }
            }
        }
        .fullScreenCover(isPresented: $showStories, onDismiss: {
            // FIX: Обновляем сторис при закрытии
            storiesRefreshTrigger = UUID()
        }) {
            StoriesView(stories: Story.samples, startIndex: selectedStoryIndex ?? 0)
        }
    }
    
    // MARK: - Components
    
    // MARK: Stories Collection
    
    private var storiesCollection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(Story.samples.enumerated()), id: \.element.id) { index, story in
                    StoryCellView(story: story, refreshTrigger: storiesRefreshTrigger) {
                        selectedStoryIndex = index
                        showStories = true
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 140)
        .padding(.vertical, 24)
    }
    
    // MARK: Direction Panel
    
    private var directionPanel: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    appNavigator.push(.cityPicker(.from))
                } label: {
                    Text(tripSelection.fromStation?.title ?? "Откуда")
                        .lineLimit(1)
                        .foregroundColor(tripSelection.fromStation == nil ? .yGrayUniversal : .yBlackUniversal)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button {
                    appNavigator.push(.cityPicker(.to))
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
                    .fontWeight(.semibold)
                    .foregroundColor(.yBlue)
                    .frame(width: 36, height: 36)
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
    }
    
    // MARK: Search Button
    
    @ViewBuilder
    private var searchButton: some View {
        if isFormComplete {
            Button {
                if let from = tripSelection.fromStation, let to = tripSelection.toStation {
                    appNavigator.push(.schedules(from: from, to: to))
                }
            } label: {
                Text("Найти")
                    .bold()
                    .foregroundColor(.yWhiteUniversal)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 48)
                    .background(Color.yBlue)
                    .cornerRadius(16)
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(TripSelection())
        .environment(AppNavigator())
}
