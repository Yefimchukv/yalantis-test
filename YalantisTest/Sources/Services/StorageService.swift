//
//  StorageService.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 05.11.2021.
//

import Foundation

protocol AnswerProviderProtocol {
    func loadAnswer() async throws -> Answer
}

class StorageService: AnswerProviderProtocol {
    
    private var hardcodedAnswers: [Answer] = []
    
    func loadAnswer() async throws -> Answer {
        hardcodedAnswers = [
            Answer(magic: Answer.Magic(question: "", answer: "HEAL YEAH!", type: "Positive")),
            Answer(magic: Answer.Magic(question: "", answer: "NO WAY", type: "Negative")),
            Answer(magic: Answer.Magic(question: "", answer: "50/50, it's up to you", type: "Neutral"))
        ]
        
        return hardcodedAnswers.randomElement()!
        
    }
}
