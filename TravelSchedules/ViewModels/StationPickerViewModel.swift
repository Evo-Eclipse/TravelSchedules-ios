//
//  StationPickerViewModel.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation

@Observable final class StationPickerViewModel {
    private let stationRepository: StationRepository
    
    var searchQuery: String = ""
    var stations: [Station] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    var filteredStations: [Station] {
        if searchQuery.isEmpty {
            return stations
        }
        return stations.filter {
            $0.title.localizedCaseInsensitiveContains(searchQuery.trimmingCharacters(in: .whitespaces)) ||
            $0.code.localizedCaseInsensitiveContains(searchQuery.trimmingCharacters(in: .whitespaces))
        }
    }
    
    init(stationRepository: StationRepository) {
        self.stationRepository = stationRepository
    }
    
    func loadStations(cityCode: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            stations = try await stationRepository.stations(in: cityCode)
        } catch {
            errorMessage = "Не удалось загрузить список станций"
        }
        
        isLoading = false
    }
    
    // TODO: INVESTIGATE
    func searchStations(cityCode: String) async {
        do {
            stations = try await stationRepository.searchStations(cityCode: cityCode, query: searchQuery, limit: 50)
        } catch {
            errorMessage = "Ошибка поиска станций"
        }
    }
}
