//
//  BallModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 14.11.2021.
//

import Foundation
import RxSwift

final class BallModel: NavigationNode {

    /// Manages network/local services
    private let answerDependencyManager: DependencyManagerProtocol
    /// Service that provides answer
    private var answerProvider: AnswerProviderProtocol
    
    private let secureStorage: SecureStorageProtocol
    
    private let dbService: DBServiceProtocol
    
    init(parent: NavigationNode, answerDependencyManager: DependencyManagerProtocol, secureStorage: SecureStorageProtocol, dbService: DBServiceProtocol) {
        self.answerDependencyManager = answerDependencyManager
        self.secureStorage = secureStorage
        self.answerProvider = self.answerDependencyManager.currentService
        self.dbService = dbService
        
        super.init(parent: parent)
    }
    
    // MARK: - Answer
    func refreshAnswerProvider() {
        self.answerProvider = answerDependencyManager.currentService
    }
    
    func fetchAnswer() -> Observable<Answer> {
        answerProvider.loadAnswer().map { $0.toAnswer() }
        
    }
    
    // MARK: - Core Data
    func saveAnswerData(answer: PresentableAnswer) {
        dbService.saveData(answer: answer)
    }
    
    // MARK: - Keychain
    func saveCounterValue(of value: String, with key: String) {
        secureStorage.saveValue(of: value, with: key)
    }
    
    func loadValue(with key: String) -> Observable<KeychainValue> {
        secureStorage.loadValue(with: key)
        return secureStorage.observable.map { $0.toKeychainValue() }
        
    }
    
    func resetValue(with key: String) {
        secureStorage.resetValue(with: key)
    }
}
