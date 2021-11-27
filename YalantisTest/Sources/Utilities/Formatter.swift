//
//  Formatter.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 26.11.2021.
//

import Foundation

enum Formatter {
    enum Date {
       static let timeMonthYearFormat: DateFormatter = {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm d.MM.yyyy"
           return dateFormatter
       }()
   }
}
