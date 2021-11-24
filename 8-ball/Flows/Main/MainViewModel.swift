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
    
    func getPresentableAnswer() -> PresentableAnswer {
        let answer = mainModel.getAnswer()
        return answer.toPresentableAnswer()
    }
    
    func loadItems() {
        mainModel.loadItems()
    }
    
    func getQuantity() -> String {
        return String(mainModel.getQuantity())
    }
    
}
