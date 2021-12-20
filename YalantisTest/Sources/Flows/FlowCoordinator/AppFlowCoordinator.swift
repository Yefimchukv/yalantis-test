//
//  AppFlowCoordinator.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 20.12.2021.
//

import UIKit

final class AppFlowCoordinator: NavigationNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    
    let answerDependencyManager: AnswerDependencyManager
    let secureStorage: SecureStorage
    let dbService: DBServiceProtocol
    let settingsService: SettingsServiceProtocol
    
    init(parent: NavigationNode?, answerDependencyManager: AnswerDependencyManager, secureStorage: SecureStorage, dbService: DBServiceProtocol, settingsService: SettingsServiceProtocol) {
        self.answerDependencyManager = answerDependencyManager
        self.secureStorage = secureStorage
        self.dbService = dbService
        self.settingsService = settingsService
        super.init(parent: parent)
        
    }
    
    func createFlow() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .systemRed
        tabBarController.viewControllers = [createMagickBallNC(), createHistoryNC(), createSettingsNC()]
        return tabBarController
    }
    
    // MARK: - MagicBall
    private func createMagickBallNC() -> UINavigationController {
        
        let magicBallCoordinator = MagicBallCoordinator(parent: self, answerDependencyManager: answerDependencyManager, answerProvider: answerDependencyManager.currentService, secureStorage: secureStorage, dbService: dbService)
        let magicBallVC = magicBallCoordinator.createFlow()
        
        magicBallVC.tabBarItem = UITabBarItem(title: L10n.Titles.magicBall,
                                              image: SFSymbols.questionmark,
                                              tag: 0)
        
        return UINavigationController(rootViewController: magicBallVC)
    }
    
    // MARK: - History
    private func createHistoryNC() -> UINavigationController {
        let historyCoordinator = HistoryFlowCoordinator(parent: self, storage: dbService)
        let historyVC = historyCoordinator.createFlow()
        
        historyVC.title = L10n.Titles.history
        historyVC.tabBarItem = UITabBarItem(title: L10n.Titles.history, image: SFSymbols.bookClosed, tag: 1)
        
        return UINavigationController(rootViewController: historyVC)
    }
    
    // MARK: - Settings
    private func createSettingsNC() -> UINavigationController {
        let settingsCoordinator = SettingsCoordinator(parent: self, settingsProvider: settingsService)
        let settingsVC = settingsCoordinator.createFlow()
        
        settingsVC.title = L10n.Titles.settings
        settingsVC.tabBarItem = UITabBarItem(title: L10n.Titles.settings,
                                             image: SFSymbols.gearshape,
                                             tag: 2)
        
        return UINavigationController(rootViewController: settingsVC)
    }
}
