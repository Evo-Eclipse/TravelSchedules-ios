//
//  SchedulesViewModel.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation

@Observable final class SchedulesViewModel {
    private let scheduleRepository: ScheduleRepository
    private let carrierRepository: CarrierRepository
    let filtersViewModel = FiltersViewModel()
    
    var segments: [TripSegment] = []
    var filteredSegments: [TripSegment] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    var fromStation: Station?
    var toStation: Station?
    
    // Filter state
    var selectedTimeRanges: Set<TimeRange> = []
    var showWithTransfers: Bool? = nil
    
    init(scheduleRepository: ScheduleRepository, carrierRepository: CarrierRepository) {
        self.scheduleRepository = scheduleRepository
        self.carrierRepository = carrierRepository
    }
    
    func loadSchedules(from originCode: String, to destinationCode: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            segments = try await scheduleRepository.searchSegments(from: originCode, to: destinationCode)
            applyFilters()
        } catch {
            errorMessage = "Не удалось загрузить расписание"
            segments = []
            filteredSegments = []
        }
        
        isLoading = false
    }
    
    func applyFilters() {
        var result = segments
        
        // Filter by time ranges if selected
        if !selectedTimeRanges.isEmpty {
            result = result.filter { segment in
                guard let departureTime = segment.departureTime,
                      let hour = parseHourFromTime(departureTime) else {
                    return false
                }
                return selectedTimeRanges.contains { $0.contains(hour: hour) }
            }
        }
        
        // Filter out transfers if "No" is selected
        if showWithTransfers == false {
            result = result.filter { segment in
                !(segment.thread?.title?.contains("пересадк") ?? false)
            }
        }
        
        filteredSegments = result
    }
    
    private func parseHourFromTime(_ timeString: String) -> Int? {
        // Parse "HH:mm:ss" or "HH:mm" to extract hour
        let components = timeString.split(separator: ":")
        guard let hourString = components.first else {
            return nil
        }
        
        let hourStr = String(hourString).trimmingCharacters(in: .whitespaces)
        guard let hour = Int(hourStr) else {
            return nil
        }
        
        return hour
    }
}
