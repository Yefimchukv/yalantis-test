//
//  DependencyManager.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 07.11.2021.
//

import Foundation

protocol AnswerProviderProtocol {
    func loadAnswer() async throws -> ManagedAnswer
}

protocol DependencyManagerProtocol {
    var storageService: AnswerProviderProtocol! { get }
    
    var currentService: AnswerProviderProtocol { get }
}

class AnswerDependencyManager: DependencyManagerProtocol {
    
    var storageService: AnswerProviderProtocol!
    
    var currentService: AnswerProviderProtocol {
        if !UserDefaults.standard.bool(forKey: DefaultsKey.straightPredictions) {
            storageService = NetworkStorageService()
            return storageService
        } else {
            storageService = StorageService()
            return storageService
        }
    }
}
