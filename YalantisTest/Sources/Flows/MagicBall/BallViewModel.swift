//
//  BallViewModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 13.11.2021.
//

import Foundation
import RxSwift

final class BallViewModel {
    
    private let model: BallModel
    
    init(model: BallModel) {
        self.model = model
    }
    
    func fetchAnswer() -> Observable<PresentableAnswer> {
        model.fetchAnswer().map { $0.toPresentableAnswer() }
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
    
    func loadValue(with key: String) -> Observable<PresentableKeychainValue> {
        model.loadValue(with: key).map { $0.toPresentableKeychainValue() }
    }
    
    func resetValue(with key: String) {
        model.resetValue(with: key)
    }
}
