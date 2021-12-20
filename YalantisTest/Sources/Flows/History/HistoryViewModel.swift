//
//  HistoryViewModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import Foundation
import RxSwift

final class HistoryViewModel {
    
    var items: [SavedAnswer] = []
    
    private let model: HistoryModel
    
    private let disposeBag = DisposeBag()
    
    init(model: HistoryModel) {
        self.model = model
    }
    
    func loadData() {
        items = model.loadData()
    }
    
    func deleteData(for indexPath: Int) -> Observable<Void> {
        model.deleteData(for: indexPath)
    }
    
    func subscribeOnEventsForDB() {
        model.subscribeOnEventsForDB()
    }
}
