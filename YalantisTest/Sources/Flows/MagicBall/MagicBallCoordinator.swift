//
//  MagicBallCoordinator.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 20.12.2021.
//

import UIKit

final class MagicBallCoordinator: NavigationNode, FlowCoordinator {
    var containerViewController: UIViewController?
    
    let answerDependencyManager: DependencyManagerProtocol
    /// Service that provides answer
    var answerProvider: AnswerProviderProtocol
    
    let secureStorage: SecureStorageProtocol
    
    let dbService: DBServiceProtocol
    
    init(parent: NavigationNode, answerDependencyManager: AnswerDependencyManager, answerProvider: AnswerProviderProtocol, secureStorage: SecureStorage, dbService: DBServiceProtocol) {
        self.answerDependencyManager = answerDependencyManager
        self.answerProvider = answerProvider
        self.secureStorage = secureStorage
        self.dbService = dbService
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let magicBallModel = BallModel(parent: self, answerDependencyManager: answerDependencyManager, secureStorage: secureStorage, dbService: dbService)
        
        let magicBallViewModel = BallViewModel(model: magicBallModel)
        let magicBallViewController = MagicBallVC(viewModel: magicBallViewModel)
        
        return magicBallViewController
    }
}
