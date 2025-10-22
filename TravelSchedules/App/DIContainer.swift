//
//  DIContainer.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation
import SwiftUI

// MARK: - Dependency Container Protocol

protocol DIContainerProtocol: Sendable {
    var client: Client { get }
    var allStationsService: AllStationsServiceProtocol { get }
    var nearestCityService: NearestCityServiceProtocol { get }
    var nearestStationsService: NearestStationsServiceProtocol { get }
    var scheduleService: ScheduleBetweenStationsServiceProtocol { get }
    var carrierInfoService: CarrierInfoServiceProtocol { get }
    
    // Repositories (кэшируемые)
    var cityRepository: CityRepository { get }
    var stationRepository: StationRepository { get }
    var scheduleRepository: ScheduleRepository { get }
    var carrierRepository: CarrierRepository { get }

    @MainActor func makeCityPickerViewModel() -> CityPickerViewModel
    @MainActor func makeStationPickerViewModel() -> StationPickerViewModel
    @MainActor func makeSchedulesViewModel() -> SchedulesViewModel
}

// MARK: - Dependency Container Implementation

final class DIContainer: DIContainerProtocol, @unchecked Sendable {
    static let shared = DIContainer()

    // MARK: - Services

    private(set) lazy var client: Client = {
        do {
            return try APIClientProvider.make(apiKey: Constants.apiKey)
        } catch {
            fatalError("Failed to initialize API client: \(error)")
        }
    }()

    private(set) lazy var allStationsService: AllStationsServiceProtocol =
        AllStationsService(client: client)

    private(set) lazy var nearestCityService: NearestCityServiceProtocol =
        NearestCityService(client: client)

    private(set) lazy var nearestStationsService: NearestStationsServiceProtocol =
        NearestStationsService(client: client)

    private(set) lazy var scheduleService: ScheduleBetweenStationsServiceProtocol =
        ScheduleBetweenStationsService(client: client)

    private(set) lazy var carrierInfoService: CarrierInfoServiceProtocol =
        CarrierInfoService(client: client)
    
    // MARK: - Repositories (Singleton)

    private(set) lazy var cityRepository: CityRepository =
        CityRepository(
            allStationsService: allStationsService,
            nearestCityService: nearestCityService
        )
    
    private(set) lazy var stationRepository: StationRepository =
        StationRepository(
            allStationsService: allStationsService,
            nearestStationsService: nearestStationsService
        )
    
    private(set) lazy var scheduleRepository: ScheduleRepository =
        ScheduleRepository(scheduleService: scheduleService)
    
    private(set) lazy var carrierRepository: CarrierRepository =
        CarrierRepository(service: carrierInfoService)

    // MARK: - Factories

    @MainActor
    func makeCityPickerViewModel() -> CityPickerViewModel {
        CityPickerViewModel(cityRepository: cityRepository)
    }

    @MainActor
    func makeStationPickerViewModel() -> StationPickerViewModel {
        StationPickerViewModel(stationRepository: stationRepository)
    }

    @MainActor
    func makeSchedulesViewModel() -> SchedulesViewModel {
        SchedulesViewModel(
            scheduleRepository: scheduleRepository,
            carrierRepository: carrierRepository
        )
    }
    
    private init() {}
}

// MARK: - Environment Integration

extension EnvironmentValues {
    @Entry var dependencies: any DIContainerProtocol = DIContainer.shared
}

// MARK: - View Extension

extension View {
    func withDependencies(_ container: (any DIContainerProtocol)? = nil) -> some View {
        environment(\.dependencies, container ?? DIContainer.shared)
    }
}
