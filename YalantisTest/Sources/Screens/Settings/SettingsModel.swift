//
//  SettingsModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 16.11.2021.
//

import Foundation

class SettingsModel {
    private var settingsProvider: SettingsServiceProtocol
    
    private var settings: [Setting] = []
    
    init() {
        self.settingsProvider = SettingsService()
    }
    
    func loadSettings() {
        settings = settingsProvider.loadSettings()
    }
    
    func numberOfSettings() -> Int {
        return settings.count
    }
    
    func setting(at index: Int) -> Setting {
        return settings[index]
    }
}
