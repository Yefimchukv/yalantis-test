//
//  HistoryFlowCoordinator.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 20.12.2021.
//

import UIKit

final class HistoryFlowCoordinator: NavigationNode, FlowCoordinator {
    
    var containerViewController: UIViewController?
    private let dbService: DBServiceProtocol
    
    init(parent: NavigationNode, storage: DBServiceProtocol) {
        
        self.dbService = storage
        
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let historyModel = HistoryModel(parent: self, dbService: dbService)
        
        let historyViewModel = HistoryViewModel(model: historyModel)
        let historyViewController = HistoryVC(viewModel: historyViewModel)
        
//        let historyTabBarItem = UITabBarItem(title: historyTitle,
//                                             image: historyImage,
//                                             selectedImage: historySelectedImage)
//        historyViewController?.tabBarItem = historyTabBarItem
        
        return historyViewController
    }
}
