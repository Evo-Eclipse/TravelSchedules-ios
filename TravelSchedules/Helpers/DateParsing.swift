//
//  DateParsing.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

enum DateParsing {
    static func parseISO8601(_ string: String) -> Date? {
        if let date = isoWithFractionalSeconds.date(from: string) { return date }
        if let date = isoBasic.date(from: string) { return date }

        // API actually returns non-ISO values as well
        let patterns = [
            // Space-separated datetime with seconds
            "yyyy-MM-dd HH:mm:ss",
            // Date-only
            "yyyy-MM-dd"
        ]
        for pattern in patterns {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateFormat = pattern
            if let date = formatter.date(from: string) { return date }
        }
        // Time-only strings (e.g., "00:10", "00:10:00") are intentionally NOT parsed
        // here to avoid anchoring to an arbitrary date. Return nil instead.
        return nil
    }

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
    
    // Parse date string like "2025-10-13" to Date for formatting
    static func parseDateString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: dateString)
    }
}
