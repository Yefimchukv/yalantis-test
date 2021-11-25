//
//  YTTabBarController.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 19.10.2021.
//

import UIKit

class YTTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemRed
        viewControllers = [createMagicBallNC(), createHistoryNC(), createSettingsNC()]
    }
    
    private func createMagicBallNC() -> UINavigationController {
        let dependencyManager = AnswerDependencyManager()
        let secureStorage = SecureStorage()
        let dbService = CoreDataService()
        let model = BallModel(answerDependencyManager: dependencyManager, secureStorage: secureStorage, dbSerive: dbService)
        let viewModel = BallViewModel(model: model)
        let magicBallVC = MagicBallVC(viewModel: viewModel)
        
        magicBallVC.tabBarItem = UITabBarItem(title: L10n.Titles.magicBall,
                                              image: SFSymbols.questionmark,
                                              tag: 0)
        
        return UINavigationController(rootViewController: magicBallVC)
    }
    
    private func createHistoryNC() -> UINavigationController {
        let dbService = CoreDataService()
        let model = HistoryModel(dbService: dbService)
        let viewModel = HistoryViewModel(model: model)
        let historyVC = HistoryVC(viewModel: viewModel)
        
        historyVC.title = L10n.Titles.history
        
        historyVC.tabBarItem = UITabBarItem(title: L10n.Titles.history, image: SFSymbols.bookClosed, tag: 1)
        
        return UINavigationController(rootViewController: historyVC)
    }
        
    private func createSettingsNC() -> UINavigationController {
        let settingsProvider = SettingsService()
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
