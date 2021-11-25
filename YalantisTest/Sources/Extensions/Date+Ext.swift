//
//  Date+Ext.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 25.11.2021.
//

import Foundation

extension Date {
    func convertToTimeMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm d.MM.yyyy"
        return dateFormatter.string(from: self)
    }
}
