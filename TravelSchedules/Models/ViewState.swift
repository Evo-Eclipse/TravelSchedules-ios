//
//  ViewState.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 14.10.2025.
//

import Foundation

enum ViewState<T> {
    case idle
    case loading
    case loaded(T)
    case error(ErrorType)
    
    enum ErrorType {
        case network
        case server
    }
    
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var data: T? {
        if case .loaded(let value) = self { return value }
        return nil
    }
    
    var error: ErrorType? {
        if case .error(let errorType) = self { return errorType }
        return nil
    }
}
