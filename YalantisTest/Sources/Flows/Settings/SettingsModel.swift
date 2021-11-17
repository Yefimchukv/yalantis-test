//
//  SettingsModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 16.11.2021.
//

import Foundation

final class SettingsModel {
    private let settingsProvider: SettingsServiceProtocol
    
    private var settings: [Setting] = []
    
    init(settingsProvider: SettingsServiceProtocol) {
        self.settingsProvider = settingsProvider
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
