//
//  HistoryViewModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import Foundation

final class HistoryViewModel {
    
    var items: [SavedAnswer] = []
    
    private let model: HistoryModel
    
    init(model: HistoryModel) {
        self.model = model
    }
    
    func loadData() {
        items = model.loadData()
    }
    
    func deleteData(for indexPath: Int) {
        model.deleteData(for: indexPath)
    }
    
    func subscribeOnEventsForDB() {
        model.subscribeOnEventsForDB()
    }
}
