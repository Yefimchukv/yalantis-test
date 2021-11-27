//
//  YTTabBarControllerModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 26.11.2021.
//

import UIKit

final class YTTabBarControllerModel {
    
    let answerDependencyManager: AnswerDependencyManager
    let secureStorage: SecureStorage
    let dbService: DBServiceProtocol
    let settingsService: SettingsServiceProtocol
    
    init(answerDependencyManager: AnswerDependencyManager, secureStorage: SecureStorage, dbService: DBServiceProtocol, settingsService: SettingsServiceProtocol) {
        self.answerDependencyManager = answerDependencyManager
        self.secureStorage = secureStorage
        self.dbService = dbService
        self.settingsService = settingsService
    }
    
    func buildViewControllers() -> [UIViewController] {
        return [createMagickBallNC(), createHistoryNC(), createSettingsNC()]
    }
    
    // MARK: - MagicBall
    private func createMagickBallNC() -> UINavigationController {
        let dependencyManager = answerDependencyManager
        let secureStorage = secureStorage
        let dbService = dbService
        let model = BallModel(answerDependencyManager: dependencyManager, secureStorage: secureStorage, dbService: dbService)
        let viewModel = BallViewModel(model: model)
        let magicBallVC = MagicBallVC(viewModel: viewModel)
        
        magicBallVC.tabBarItem = UITabBarItem(title: L10n.Titles.magicBall,
                                              image: SFSymbols.questionmark,
                                              tag: 0)
        
        return UINavigationController(rootViewController: magicBallVC)
    }
    
    // MARK: - History
    private func createHistoryNC() -> UINavigationController {
        let dbService = dbService
        let model = HistoryModel(dbService: dbService)
        let viewModel = HistoryViewModel(model: model)
        let historyVC = HistoryVC(viewModel: viewModel)
        
        historyVC.title = L10n.Titles.history
        historyVC.tabBarItem = UITabBarItem(title: L10n.Titles.history, image: SFSymbols.bookClosed, tag: 1)
        
        return UINavigationController(rootViewController: historyVC)
    }
    
    // MARK: - Settings
    private func createSettingsNC() -> UINavigationController {
        let settingsProvider = settingsService
        let model = SettingsModel(settingsProvider: settingsProvider)
        let viewModel = SettingsViewModel(model: model)
        let settingsVC = SettingsVC(viewModel: viewModel)
        settingsVC.title = L10n.Titles.settings
        settingsVC.tabBarItem = UITabBarItem(title: L10n.Titles.settings,
                                             image: SFSymbols.gearshape,
                                             tag: 2)
        
        return UINavigationController(rootViewController: settingsVC)
    }
}
