//
//  AnswersViewModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 14.11.2021.
//

import Foundation
import CoreData

class AnswersViewModel {
    
    var answersModel: AnswersModel
    
    init(_ model: AnswersModel) {
        self.answersModel = model
    }
    
    func countArray() -> Int {
        return answersModel.getCount()
    }
    
    func getItem(at indexPath: IndexPath) -> Item {
        return answersModel.getItem(at: indexPath)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        answersModel.deleteItem(at: indexPath)
    }
    
    func loadItems() {
        answersModel.loadItems()
    }
    
}
