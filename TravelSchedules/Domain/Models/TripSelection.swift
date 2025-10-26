//
//  TripSelection.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 14.10.2025.
//

import Foundation

@MainActor
@Observable final class TripSelection {
    var fromCity: City?
    var fromStation: Station?
    var toCity: City?
    var toStation: Station?
    
    var isComplete: Bool {
        fromStation != nil && toStation != nil
    }
    
    func reset() {
        fromCity = nil
        fromStation = nil
        toCity = nil
        toStation = nil
    }
    
    func swapDirections() {
        swap(&fromCity, &toCity)
        swap(&fromStation, &toStation)
    }
}
