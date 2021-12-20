//
//  StorageService.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 05.11.2021.
//

import Foundation
import RxSwift

class StorageService: AnswerProviderProtocol {
    
    private var hardcodedAnswers: [ManagedAnswer] = []
    
    func loadAnswer() -> Observable<ManagedAnswer> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create()}
            
            self.hardcodedAnswers = [
                ManagedAnswer(magic: ManagedAnswer.Magic(answer: L10n.HardcodedAnswer._1, type: L10n.HardcodedAnswerTitle._1)),
                ManagedAnswer(magic: ManagedAnswer.Magic(answer: L10n.HardcodedAnswer._2, type: L10n.HardcodedAnswerTitle._2)),
                ManagedAnswer(magic: ManagedAnswer.Magic(answer: L10n.HardcodedAnswer._3, type: L10n.HardcodedAnswerTitle._3))
            ]
            
            observer.onNext(self.hardcodedAnswers.randomElement()!)
            
            return Disposables.create()
        }
    }
}
