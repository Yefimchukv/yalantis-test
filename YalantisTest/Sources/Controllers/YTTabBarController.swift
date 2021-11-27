//
//  YTTabBarController.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 19.10.2021.
//

import UIKit

class YTTabBarController: UITabBarController {
    
    var viewModel: YTTabBarControllerModel
    
    init(viewModel: YTTabBarControllerModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemRed
        viewControllers = viewModel.buildViewControllers()
    }

}
