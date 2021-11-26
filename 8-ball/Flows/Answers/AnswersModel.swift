//
//  AnswersModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 14.11.2021.
//

import Foundation
import CoreData

class AnswersModel {
    
    private var itemArray = [Item]()
    
    private var databaseManager: DBManager!
    
    init(_ dbManager: DBManager) {
        self.databaseManager = dbManager
    }
    
    func getCount() -> Int {
        return itemArray.count
    }
    
    func getItem(at indexPath: IndexPath) -> Item {
        return itemArray[indexPath.row]
    }
    
    func deleteItem(at indexPath: IndexPath) {
        databaseManager.deleteItem(at: indexPath)
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        itemArray = databaseManager.loadItems(with: request)
        itemArray.sort(by: { $0.date > $1.date })
    }
    
}
