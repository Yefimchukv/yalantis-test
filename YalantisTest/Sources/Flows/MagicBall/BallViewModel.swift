//
//  BallViewModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 13.11.2021.
//

import Foundation

final class BallViewModel {
    
    private let model: BallModel
    
    init(model: BallModel) {
        self.model = model
    }
    
    func fetchAnswer() async throws -> PresentableAnswer {
        let answerModel = try await model.fetchAnswer()
        return answerModel.toPresentableAnswer()
    }
    
    func refreshAnswerProvider() {
        model.refreshAnswerProvider()
    }
}
