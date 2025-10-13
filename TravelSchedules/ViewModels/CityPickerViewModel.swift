//
//  CityPickerViewModel.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation

@Observable final class CityPickerViewModel {
    private let cityRepository: CityRepository
    
    var searchQuery: String = ""
    var cities: [City] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    var filteredCities: [City] {
        if searchQuery.isEmpty {
            return cities
        }
        return cities.filter {
            $0.title.localizedCaseInsensitiveContains(searchQuery.trimmingCharacters(in: .whitespaces)) ||
            $0.code.localizedCaseInsensitiveContains(searchQuery.trimmingCharacters(in: .whitespaces))
        }
    }
    
    init(cityRepository: CityRepository) {
        self.cityRepository = cityRepository
    }
    
    func loadCities() async {
        isLoading = true
        errorMessage = nil
        
        do {
            cities = try await cityRepository.allCities()
        } catch {
            errorMessage = "Не удалось загрузить список городов"
        }
        
        isLoading = false
    }
    
    // TODO: INVESTIGATE
    func searchCities() async {
        let results = await cityRepository.searchCities(query: searchQuery, limit: 50)
        cities = results
    }
}
