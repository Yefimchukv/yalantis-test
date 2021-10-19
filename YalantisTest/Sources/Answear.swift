//
//  Answer.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import Foundation

struct Answer: Codable {
    struct Magic: Codable {
        let question: String
        let answer: String
        let type: String
    }
    
    let magic: Magic
}
