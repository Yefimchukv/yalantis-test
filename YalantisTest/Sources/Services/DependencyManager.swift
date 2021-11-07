//
//  DependencyManager.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 07.11.2021.
//

import Foundation

protocol DependencyManaging {
    var storageService: AnswerProviderProtocol! { get }
    
    var currentService: AnswerProviderProtocol { get }
}

class DependencyManager: DependencyManaging {
    
    var storageService: AnswerProviderProtocol!
    
    var currentService: AnswerProviderProtocol {
        if !UserDefaults.standard.bool(forKey: SettingKeys.straightPredictions) {
            storageService = NetworkStorageService()
            return storageService
        } else {
            storageService = StorageService()
            return storageService
        }
    }
}




