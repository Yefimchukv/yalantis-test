//
//  BallModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 14.11.2021.
//

import Foundation

class BallModel {
    
    /// Manages network/local services
    private var answerDependencyManager: DependencyManagerProtocol
    /// Service that provides answer
    private var answerProvider: AnswerProviderProtocol
    
    init() {
        self.answerDependencyManager = AnswerDependencyManager()
        self.answerProvider = self.answerDependencyManager.currentService
    }
    
    func refreshAnswerProvider() {
        self.answerProvider = answerDependencyManager.currentService
    }
    
    func fetchAnswer() async throws -> Answer {
        let answer = try await answerProvider.loadAnswer()
        return answer.toAnswer()
    }
}
