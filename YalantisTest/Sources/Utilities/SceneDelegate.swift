//
//  SceneDelegate.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        let viewModel = YTTabBarControllerViewModel(answerDependencyManager: AnswerDependencyManager(),
                                                    secureStorage: SecureStorage(),
                                                    dbService: CoreDataService(),
                                                    settingsService: SettingsService())
        
        let tabBar = YTTabBarController(viewModel: viewModel)
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
}
