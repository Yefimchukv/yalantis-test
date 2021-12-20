//
//  SettingsCoordinator.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 20.12.2021.
//

import UIKit

final class SettingsCoordinator: NavigationNode, FlowCoordinator {
    var containerViewController: UIViewController?
    
    let settingsProvider: SettingsServiceProtocol
    
    init(parent: NavigationNode, settingsProvider: SettingsServiceProtocol) {
        self.settingsProvider = settingsProvider
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let settingsModel = SettingsModel(settingsProvider: settingsProvider)
        let settingsViewModel = SettingsViewModel(model: settingsModel)
        let settingsVC = SettingsVC(viewModel: settingsViewModel)
        
        return settingsVC
    } 
}
