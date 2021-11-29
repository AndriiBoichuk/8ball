//
//  AnswersModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 14.11.2021.
//

import Foundation
import CoreData

class AnswersModel {
    
    private var databaseManager: DBManager!
    
    init(_ dbManager: DBManager) {
        self.databaseManager = dbManager
    }
    
    func getCount() -> Int {
        return databaseManager.getCount()
    }
    
    func getItem(at indexPath: IndexPath) -> Item {
        return databaseManager.getItem(at: indexPath)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        databaseManager.deleteItem(at: indexPath)
    }
    
    func loadItems() {
        databaseManager.loadItems()
    }
    
}
