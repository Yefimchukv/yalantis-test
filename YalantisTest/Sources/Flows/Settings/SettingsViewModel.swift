//
//  SettingsViewModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 16.11.2021.
//

import Foundation

final class SettingsViewModel {
    private let model: SettingsModel
    
    init(model: SettingsModel) {
        self.model = model
    }
    
    func loadSettings() {
        model.loadSettings()
    }
    
    func numberOfSettings() -> Int {
        return model.numberOfSettings()
    }
    
    func setting(at index: Int) -> PresentableSetting {
        let setting = model.setting(at: index).toPresentableSetting()
        
        return setting
    }
}
