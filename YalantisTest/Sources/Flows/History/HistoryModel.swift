//
//  HistoryModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import UIKit

final class HistoryModel {
    
    private let dbService: DBServiceProtocol
    
    init(dbService: DBServiceProtocol) {
        self.dbService = dbService
    }
    
    func loadData() -> [SavedAnswer] {
        dbService.loadData()
    }
    
    func subscribeOnEventsForDB() {
        dbService.subscribeOnEventsForDB()
    }
}