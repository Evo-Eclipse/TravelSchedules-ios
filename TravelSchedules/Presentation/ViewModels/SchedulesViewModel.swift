//
//  SchedulesViewModel.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation

@MainActor
@Observable final class SchedulesViewModel {
    private let scheduleRepository: ScheduleRepository
    private let carrierRepository: CarrierRepository
    let filtersViewModel = FiltersViewModel()
    
    var state: ViewState<[TripSegment]> = .idle
    var fromStation: Station?
    var toStation: Station?
    
    var selectedTimeRanges: Set<TimeRange> = []
    var showWithTransfers: Bool? = nil
    
    var filteredSegments: [TripSegment] {
        guard let segments = state.data else { return [] }
        return applyFilters(to: segments)
    }
    
    init(scheduleRepository: ScheduleRepository, carrierRepository: CarrierRepository) {
        self.scheduleRepository = scheduleRepository
        self.carrierRepository = carrierRepository
    }
    
    func loadSchedules(from originCode: String, to destinationCode: String) async {
        state = .loading
        
        do {
            let segments = try await scheduleRepository.searchSegments(
                from: originCode,
                to: destinationCode
            )
            state = .loaded(segments)
        } catch {
            state = .error(.network)
        }
    }
    
    private func applyFilters(to segments: [TripSegment]) -> [TripSegment] {
        var result = segments
        
        if !selectedTimeRanges.isEmpty {
            result = result.filter { segment in
                guard let departureTime = segment.departureTime,
                      let hour = parseHourFromTime(departureTime) else {
                    return false
                }
                return selectedTimeRanges.contains { $0.contains(hour: hour) }
            }
        }
        
        if showWithTransfers == false {
            result = result.filter { segment in
                !segment.hasTransfers
            }
        }
        
        return result
    }
    
    private func parseHourFromTime(_ timeString: String) -> Int? {
        let components = timeString.split(separator: ":")
        guard let hourString = components.first else { return nil }
        
        let hourStr = String(hourString).trimmingCharacters(in: .whitespaces)
        return Int(hourStr)
    }
}
