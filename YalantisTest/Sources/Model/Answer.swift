//
//  AnswerModel.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import Foundation

// MARK: - ManagedAnswer
struct ManagedAnswer: Codable {
    struct Magic: Codable {
        let answer: String
        let type: String
    }
    
    let magic: Magic
}

extension ManagedAnswer {
    func toAnswer() -> Answer {
        return Answer(magic: Answer.Magic(answer: self.magic.answer, type: self.magic.type))
    }
}

// MARK: - Answer
struct Answer: Codable {
    struct Magic: Codable {
        let answer: String
        let type: String
    }
    
    let magic: Magic
}

extension Answer {
    func toPresentableAnswer() -> PresentableAnswer {
        return PresentableAnswer(model: self)
    }
}

// MARK: - PresentableAnswer
struct PresentableAnswer {
    var model: Answer
    
    init(model: Answer) {
        self.model = model
    }
    
    var answerTitle: String {
        return model.magic.type.uppercased()
    }
    
    var answerSubtitle: String {
        return model.magic.answer.uppercased()
    }
}
