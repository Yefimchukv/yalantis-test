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
        
        let appCoordinator = AppFlowCoordinator(parent: nil, answerDependencyManager: AnswerDependencyManager(),
                                                secureStorage: SecureStorage(),
                                                dbService: CoreDataService(),
                                                settingsService: SettingsService())
        
        let controller = appCoordinator.createFlow()
        appCoordinator.containerViewController = controller
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
