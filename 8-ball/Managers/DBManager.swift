//
//  DBManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 09.11.2021.
//

import CoreData
import UIKit

protocol ManagedObjectConvertible {

    func loadItems()
    func deleteItem(at indexPath: IndexPath)
    func saveItems()
    
}

final class DBManager: ManagedObjectConvertible {
    
    private var context: NSManagedObjectContext
    
    private var itemArray = [Item]()
    
    init() {
        context = {
            let container = NSPersistentContainer(name: L10n.PersistentContainer.name)
            container.loadPersistentStores(completionHandler: { (_, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container.viewContext
        }()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate(notification:)), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    @objc func appWillTerminate(notification: Notification) {
        saveItems()
    }
    
    func getContext() -> NSManagedObjectContext {
        return context
    }
    
    func loadItems() {
        context.perform {
            do {
                let request = Item.fetchRequest()
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
    
    func getItem(at index: Int) -> Item {
        return itemArray[index]
    }
    
    func checkRepetiton(at str: String) -> Bool {
        for item in itemArray where item.hardcodedAnswer == str {
            return true
        }
        return false
    }
    
}
