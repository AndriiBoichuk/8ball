//
//  MainViewModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 13.11.2021.
//

import Foundation

class MainViewModel {
    
    var mainModel: MainModel
    
    init(_ model: MainModel) {
        self.mainModel = model
    }
    
    func getPresentableAnswer(completion: @escaping ((PresentableAnswer) -> Void)) {
        var presentAnswer = PresentableAnswer(answer: "")
        mainModel.getAnswer { answer in
            presentAnswer = answer.toPresentableAnswer()
            completion(presentAnswer)
        }
    }
    
    func loadItems() {
        mainModel.loadItems()
    }
    
    func getQuantity() -> String {
        return String(mainModel.getQuantity())
    }
    
    func addAnswer(_ answer: String) {
        mainModel.addAnswer(answer)
    }
    
}
