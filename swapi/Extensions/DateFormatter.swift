//
//  DateFormatter.swift
//  swapi
//
//  Created by Nicolas Desormiere on 9/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let ddMMyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }()
    
    static let ddMMyyhmma: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yy h:mma"
        return formatter
    }()
    
    static let yyyyMMddTHHmmssSSSZ: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
}
