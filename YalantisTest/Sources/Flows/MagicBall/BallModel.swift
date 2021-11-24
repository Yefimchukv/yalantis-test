//
//  BallModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 14.11.2021.
//

import Foundation

final class BallModel {

    /// Manages network/local services
    private let answerDependencyManager: DependencyManagerProtocol
    /// Service that provides answer
    private var answerProvider: AnswerProviderProtocol
    
    private let secureStorage: SecureStorageProtocol
    
    init(answerDependencyManager: DependencyManagerProtocol, secureStorage: SecureStorageProtocol) {
        self.answerDependencyManager = answerDependencyManager
        self.secureStorage = secureStorage
        self.answerProvider = self.answerDependencyManager.currentService
        
    }
    
    // MARK: - Answer
    func refreshAnswerProvider() {
        self.answerProvider = answerDependencyManager.currentService
    }
    
    func fetchAnswer() async throws -> Answer {
        let answer = try await answerProvider.loadAnswer()
        return answer.toAnswer()
    }
    
    // MARK: - Keychain
    func saveValue(of value: String, with key: String) {
        secureStorage.saveValue(of: value, with: key)
    }
    
    func loadValue(with key: String) -> KeychainValue {
        return secureStorage.loadValue(with: key).toKeychainValue()
    }
    
    func resetValue(with key: String) {
        secureStorage.resetValue(with: key)
    }
}
