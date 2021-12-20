//
//  Coordinator.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 20.12.2021.
//

import Foundation
import UIKit

public protocol FlowCoordinator {

    var containerViewController: UIViewController? { get set }

    @discardableResult
    func createFlow() -> UIViewController

}
