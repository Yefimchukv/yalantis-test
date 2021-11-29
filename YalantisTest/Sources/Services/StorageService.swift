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
            ManagedAnswer(magic: ManagedAnswer.Magic(answer: L10n.HardcodedAnswer._1, type: L10n.HardcodedAnswerTitle._1)),
            ManagedAnswer(magic: ManagedAnswer.Magic(answer: L10n.HardcodedAnswer._2, type: L10n.HardcodedAnswerTitle._2)),
            ManagedAnswer(magic: ManagedAnswer.Magic(answer: L10n.HardcodedAnswer._3, type: L10n.HardcodedAnswerTitle._3))
        ]
        
        return hardcodedAnswers.randomElement()!
        
    }
}
