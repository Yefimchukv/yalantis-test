//
//  SettingsService.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 16.11.2021.
//

import Foundation

protocol SettingsServiceProtocol {
    var settingsArray: [ManagedSetting] { get }
    
    func loadSettings() -> [Setting]
}

class SettingsService: SettingsServiceProtocol {
    var settingsArray: [ManagedSetting] = []
    
    func loadSettings() -> [Setting] {
        
        // Gonna be some DB calls in further
        settingsArray = [
            ManagedSetting(name: L10n.SettingsName.straightPredictions,
                           defaultsKey: DefaultsKey.straightPredictions,
                    hasSwitch: true)
        ]
        
        return settingsArray.map { $0.toSetting() }
    }
}
