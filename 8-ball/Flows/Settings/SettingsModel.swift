//
//  SettingsModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 14.11.2021.
//

import Foundation

class SettingsModel {
    
    private var databaseManager: DBManager!
    
    init(_ dbManager: DBManager) {
        self.databaseManager = dbManager
    }
    
    func addItem(_ answer: String) {
        let newItem = Item(context: databaseManager.getContext())
        newItem.hardcodedAnswer = answer
        newItem.date = Date().timeIntervalSince1970
        databaseManager.addItem(newItem)
        
        databaseManager.saveItems()
    }
    
    func loadItems() {
        databaseManager.loadItems()
    }
    
    func getDBManager() -> DBManager {
        return databaseManager
    }
    
}
