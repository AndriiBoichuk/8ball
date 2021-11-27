//
//  DBManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 09.11.2021.
//

import CoreData

protocol ManagedObjectConvertible {

    func loadItems(with request: NSFetchRequest<Item>)
    func deleteItem(at indexPath: IndexPath)
    func saveItems()
    
}

final class DBManager: ManagedObjectConvertible {
    
    private var itemArray = [Item]()
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        context.perform {
            do {
                self.itemArray = try self.context.fetch(request)
                self.itemArray.sort(by: { $0.date > $1.date })
            } catch {
                fatalError("Error loading items \(error)")
            }
        }
    }
    
    func addItem(_ item: Item) {
        itemArray.append(item)
        
        saveItems()
    }
    
    func deleteItem(at indexPath: IndexPath) {
        print(indexPath.row)
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        saveItems()
    }
    
    func saveItems() {
        context.perform {
            do {
                try self.context.save()
            } catch {
                print("Error saving context, \(error)")
            }
        }
       
    }
    
    func getCount() -> Int {
        return itemArray.count
    }
    
    func getItem(at indexPath: IndexPath) -> Item {
        return itemArray[indexPath.row]
    }
    
    func checkRepetiton(at str: String) -> Bool {
        for item in itemArray where item.hardcodedAnswer == str {
            return true
        }
        return false
    }
    
}
