//
//  Answer.swift
//  8-ball
//
//  Created by Андрій Бойчук on 13.11.2021.
//

import Foundation

struct Answer {
    let answer: String
    let type: String?
}

extension Answer {
    
    func toPresentableAnswer() -> PresentableAnswer {
        let presentableAnswer = PresentableAnswer(answer: answer.capitalized)
        return presentableAnswer
    }
    
}
