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
    
    
    func createMagicBallNC() -> UINavigationController {
        let searchVC = MagicBallVC()
        searchVC.tabBarItem = UITabBarItem(title: "Magic Ball",
                                           image: SFSymbols.questionmark,
                                           tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createSettingsNC() -> UINavigationController {
        let settingsVC = SettingsVC()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: "Settings",
                                             image: SFSymbols.gearshape,
                                             tag: 1)
        
        return UINavigationController(rootViewController: settingsVC)
    }
}
