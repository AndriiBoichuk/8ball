//
//  SettingsModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 14.11.2021.
//

import Foundation

class SettingsModel {
    
    private var itemArray = [Item]()
    
    private var databaseManager: DBManager!
    
    init(_ dbManager: DBManager) {
        self.databaseManager = dbManager
    }
    
    func addItem(_ answer: String) {
        let newItem = Item(context: databaseManager.context)
        newItem.hardcodedAnswer = answer
        itemArray.append(newItem)
        
        databaseManager.saveItems()
    }
    
    func loadItems() {
        itemArray = databaseManager.loadItems()
    }
    
    func getDBManager() -> DBManager {
        return databaseManager
    }
    
}
