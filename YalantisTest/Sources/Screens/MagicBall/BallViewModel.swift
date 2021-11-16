//
//  BallViewModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 13.11.2021.
//

import Foundation

class BallViewModel {
    
    private let model = BallModel()
    
    func fetchAnswer() async throws -> PresentableAnswer {
        let answerModel = try await model.fetchAnswer()
        return answerModel.toPresentableAnswer()
    }
    
    func refreshAnswerProvider() {
        model.refreshAnswerProvider()
    }
}
