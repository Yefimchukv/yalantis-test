//
//  Date+Ext.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 25.11.2021.
//

import Foundation

extension Date {
    func convertToTimeMonthYearFormat() -> String {
        return Formatter.Date.timeMonthYearFormat.string(from: self)
    }
}
