//
//  DBManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 09.11.2021.
//

import CoreData

protocol ManagedObjectConvertible {

    func loadItems(with request: NSFetchRequest<Item>) -> [Item]
    func deleteItem(at indexPath: IndexPath)
    func saveItems()
    
}

final class DBManager: ManagedObjectConvertible {
    
    private var itemArray = [Item]()
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) -> [Item] {
        do {
            itemArray = try context.fetch(request)
            return itemArray
        } catch {
            fatalError("Error loading items \(error)")
        }
        
    }
    
    func addItem(_ item: Item) {
        itemArray.append(item)
        
        saveItems()
    }
    
    func deleteItem(at indexPath: IndexPath) {
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        saveItems()
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
    }
    
}
