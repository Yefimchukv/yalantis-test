//
//  YTError.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import Foundation

enum YTError: String, Error {
    case urlError = "Can't get to the point..."
    case internetIssue = "Get better internet connection"
    case decodeError = "I won't answer..."
}
