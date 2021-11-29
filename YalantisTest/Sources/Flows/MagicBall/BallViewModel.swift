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
    
    // MARK: - Core Data
    func saveAnswerData(answer: PresentableAnswer) {
        model.saveAnswerData(answer: answer)
    }
    
    // MARK: - Keychain
    func saveCounterValue(of value: String, with key: String) {
        model.saveCounterValue(of: "\(Int(value)! + 1)", with: key)
    }
    
    func loadValue(with key: String) -> PresentableKeychainValue {
        let value = model.loadValue(with: key)
        return value.toPresentableKeychainValue()
    }
    
    func resetValue(with key: String) {
        model.resetValue(with: key)
    }
}
