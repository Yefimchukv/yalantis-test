//
//  YTError.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import Foundation

enum YTError: String, Error {
    case urlError = "Can't get to the point..."
    case internetIssue = "I see bad connection... Try again later or try straight predictions"
    case decodeError = "Cant decode stuff so I won't answer..."
}
