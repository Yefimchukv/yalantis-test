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
        viewControllers = [createMagicBallNC(), createSettingsNC()]
    }
    
    private func createMagicBallNC() -> UINavigationController {
        let magicBallVC = MagicBallVC(viewModel: BallViewModel())
        
        magicBallVC.tabBarItem = UITabBarItem(title: L10n.Titles.magicBall,
                                              image: SFSymbols.questionmark,
                                              tag: 0)
        
        return UINavigationController(rootViewController: magicBallVC)
    }
        
    private func createSettingsNC() -> UINavigationController {
        let settingsVC = SettingsVC()
        settingsVC.title = L10n.Titles.settings
        settingsVC.tabBarItem = UITabBarItem(title: L10n.Titles.settings,
                                             image: SFSymbols.gearshape,
                                             tag: 1)
        
        return UINavigationController(rootViewController: settingsVC)
    }
}
