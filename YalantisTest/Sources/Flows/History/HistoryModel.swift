//
//  HistoryModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import UIKit
import RxSwift

class HistoryModel: NavigationNode {
    
    private let dbService: DBServiceProtocol
    
    init(parent: NavigationNode, dbService: DBServiceProtocol) {
        self.dbService = dbService
        super.init(parent: parent)
    }
    
    func loadData() -> [SavedAnswer] {
        dbService.loadData()
    }
    
    func deleteData(for indexPath: Int) -> Observable<Void> {
        dbService.deleteData(for: indexPath)
    }
    
    func subscribeOnEventsForDB() {
        dbService.subscribeOnEventsForDB()
    }
}
