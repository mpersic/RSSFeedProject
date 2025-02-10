//
//  DateFormatter=.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import Foundation

extension DateFormatter {
    static let defaultFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // ISO 8601
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        return formatter
    }()
}
