//
//  AppNavigator.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 14.10.2025.
//

import SwiftUI

@Observable
final class AppNavigator {
    var path: NavigationPath = .init()
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop(_ count: Int = 1) {
        guard count > 0 else { return }
        path.removeLast(min(count, path.count))
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
