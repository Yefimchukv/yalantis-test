//
//  StorageService.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 05.11.2021.
//

import Foundation

class StorageService: AnswerProviderProtocol {
    
    private var hardcodedAnswers: [ManagedAnswer] = []
    
    func loadAnswer() async throws -> ManagedAnswer {
        
        // Gonna be some DB calls in further
        hardcodedAnswers = [
            ManagedAnswer(magic: ManagedAnswer.Magic(answer: "HELL YEAH!", type: "Positive")),
            ManagedAnswer(magic: ManagedAnswer.Magic(answer: "NO WAY", type: "Negative")),
            ManagedAnswer(magic: ManagedAnswer.Magic(answer: "50/50, it's up to you", type: "Neutral"))
        ]
        
        return hardcodedAnswers.randomElement()!
        
    }
}
