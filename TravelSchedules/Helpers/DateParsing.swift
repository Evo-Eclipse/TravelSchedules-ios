//
//  DateParsing.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

enum DateParsing {
    
    // MARK: - Static Formatters
    
    private static let isoBasic: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    private static let isoWithFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    private static let dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    private static let dateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    // MARK: - Parsing Methods
    
    static func parseISO8601(_ string: String) -> Date? {
        if let date = isoWithFractionalSeconds.date(from: string) { return date }
        if let date = isoBasic.date(from: string) { return date }
        if let date = dateTimeFormatter.date(from: string) { return date }
        if let date = dateOnlyFormatter.date(from: string) { return date }
        return nil
    }
    
    static func parseDateString(_ dateString: String) -> Date? {
        return dateOnlyFormatter.date(from: dateString)
    }
}
