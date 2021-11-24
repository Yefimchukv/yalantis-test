//
//  HistoryViewModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import Foundation

final class HistoryViewModel {
    
    private let model: HistoryModel
    
    init(model: HistoryModel) {
        self.model = model
    }
    
    func createData() {
        //
    }
    
    func saveData() {
        //
    }
    
    func loadData() -> [SavedAnswer] {
        model.loadData()
    }
    
    func updateData() {
        //
    }
    
    func deleteData() {
        //
    }
}
