//
//  AnswerData.swift
//  8-ball
//
//  Created by Андрій Бойчук on 06.10.2021.
//

import Foundation

struct AnswerData: Decodable {
    let magic: Magic
}

struct Magic: Decodable {
    let question: String
    let answer: String
    let type: String
}

extension Magic {
    func toAnswer() -> Answer {
        let answer = Answer(answer: answer, type: type)
        return answer
    }
}
