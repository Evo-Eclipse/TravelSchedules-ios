//
//  StationPickerViewModel.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation

@MainActor
@Observable final class StationPickerViewModel {
    private let stationRepository: StationRepository
    
    var searchQuery: String = ""
    var state: ViewState<[Station]> = .idle
    
    var filteredStations: [Station] {
        guard let stations = state.data else { return [] }
        
        if searchQuery.isEmpty {
            return stations
        }
        
        let trimmedQuery = searchQuery.trimmingCharacters(in: .whitespaces)
        return stations.filter {
            $0.title.localizedCaseInsensitiveContains(trimmedQuery) ||
            $0.code.localizedCaseInsensitiveContains(trimmedQuery)
        }
    }
    
    init(stationRepository: StationRepository) {
        self.stationRepository = stationRepository
    }
    
    func loadStations(cityCode: String) async {
        state = .loading
        
        do {
            let stations = try await stationRepository.stations(in: cityCode)
            state = .loaded(stations)
        } catch {
            state = .error(.network)
        }
    }
}
