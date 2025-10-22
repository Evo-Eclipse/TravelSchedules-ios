//
//  CityPickerViewModel.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation

@MainActor
@Observable final class CityPickerViewModel {
    private let cityRepository: CityRepository
    
    var searchQuery: String = ""
    var state: ViewState<[City]> = .idle
    
    var filteredCities: [City] {
        guard let cities = state.data else { return [] }
        
        if searchQuery.isEmpty {
            return cities
        }
        
        let trimmedQuery = searchQuery.trimmingCharacters(in: .whitespaces)
        return cities.filter {
            $0.title.localizedCaseInsensitiveContains(trimmedQuery) ||
            $0.code.localizedCaseInsensitiveContains(trimmedQuery)
        }
    }
    
    init(cityRepository: CityRepository) {
        self.cityRepository = cityRepository
    }
    
    func loadCities() async {
        state = .loading
        
        do {
            let cities = try await cityRepository.allCities()
            state = .loaded(cities)
        } catch {
            state = .error(.network)
        }
    }
}
