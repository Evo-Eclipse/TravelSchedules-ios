//
//  DIContainer.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation
import SwiftUI

// MARK: - Protocol for Testability

protocol DIContainerProtocol {
    var client: Client { get }
    var allStationsService: AllStationsServiceProtocol { get }
    var nearestCityService: NearestCityServiceProtocol { get }
    var nearestStationsService: NearestStationsServiceProtocol { get }
    var scheduleService: ScheduleBetweenStationsServiceProtocol { get }
    var carrierInfoService: CarrierInfoServiceProtocol { get }
    var cityRepository: CityRepository { get }
    var stationRepository: StationRepository { get }
    var scheduleRepository: ScheduleRepository { get }
    var carrierRepository: CarrierRepository { get }
    
    func makeCityPickerViewModel() -> CityPickerViewModel
    func makeStationPickerViewModel() -> StationPickerViewModel
    func makeSchedulesViewModel() -> SchedulesViewModel
}

// MARK: - Dependency Container

final class DIContainer: DIContainerProtocol {
    static let shared = DIContainer()
    
    // MARK: - Services
    
    private(set) lazy var client: Client = {
        do {
            return try APIClientProvider.make(apiKey: Constants.apiKey)
        } catch {
            fatalError("Failed to initialize API client: \(error)")
        }
    }()
    
    private(set) lazy var allStationsService: AllStationsServiceProtocol = {
        AllStationsService(client: client)
    }()
    
    private(set) lazy var nearestCityService: NearestCityServiceProtocol = {
        NearestCityService(client: client)
    }()
    
    private(set) lazy var nearestStationsService: NearestStationsServiceProtocol = {
        NearestStationsService(client: client)
    }()
    
    private(set) lazy var scheduleService: ScheduleBetweenStationsServiceProtocol = {
        ScheduleBetweenStationsService(client: client)
    }()
    
    private(set) lazy var carrierInfoService: CarrierInfoServiceProtocol = {
        CarrierInfoService(client: client)
    }()
    
    // MARK: - Repositories
    
    private(set) lazy var cityRepository: CityRepository = {
        CityRepository(
            allStationsService: allStationsService,
            nearestCityService: nearestCityService
        )
    }()
    
    private(set) lazy var stationRepository: StationRepository = {
        StationRepository(
            allStationsService: allStationsService,
            nearestStationsService: nearestStationsService
        )
    }()
    
    private(set) lazy var scheduleRepository: ScheduleRepository = {
        ScheduleRepository(scheduleService: scheduleService)
    }()
    
    private(set) lazy var carrierRepository: CarrierRepository = {
        CarrierRepository(service: carrierInfoService)
    }()
    
    // MARK: - ViewModels
    
    func makeCityPickerViewModel() -> CityPickerViewModel {
        CityPickerViewModel(cityRepository: cityRepository)
    }
    
    func makeStationPickerViewModel() -> StationPickerViewModel {
        StationPickerViewModel(stationRepository: stationRepository)
    }
    
    func makeSchedulesViewModel() -> SchedulesViewModel {
        SchedulesViewModel(
            scheduleRepository: scheduleRepository,
            carrierRepository: carrierRepository
        )
    }
    
    private init() {}
}

// MARK: - SwiftUI Environment Integration

private struct DIContainerKey: EnvironmentKey {
    static let defaultValue: DIContainerProtocol = DIContainer.shared
}

extension EnvironmentValues {
    var dependencies: DIContainerProtocol {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}

// MARK: - View Extension for Convenience

extension View {
    func withDependencies(_ container: DIContainerProtocol = DIContainer.shared) -> some View {
        self.environment(\.dependencies, container)
    }
}
