//
//  FiltersViewModel.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation

@Observable final class FiltersViewModel {
    var selectedTimeRanges: Set<TimeRange> = []
    var showWithTransfers: Bool? = nil
    
    var hasActiveFilters: Bool {
        !selectedTimeRanges.isEmpty || showWithTransfers != nil
    }
    
    func toggleTimeRange(_ range: TimeRange) {
        if selectedTimeRanges.contains(range) {
            selectedTimeRanges.remove(range)
        } else {
            selectedTimeRanges.insert(range)
        }
    }
    
    func clearFilters() {
        selectedTimeRanges.removeAll()
        showWithTransfers = nil
    }
}
