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
    
    func loadItems(with word: String = "") {
        if word.isEmpty {
            answersModel.loadItems()
        } else {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            
            let predicate = NSPredicate(format: "hardcodedAnswer CONTAINS[cd] %@", word)
            
            request.predicate = predicate
            
            let sortDescriptor = NSSortDescriptor(key: L10n.Key.answer, ascending: true)
            
            request.sortDescriptors = [sortDescriptor]
            
            answersModel.loadItems(with: request)
        }
    }
    
}
