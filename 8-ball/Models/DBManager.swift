//
//  DBManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 09.11.2021.
//

import UIKit
import CoreData

protocol DBDelegateProtocol {
    func reloadTableView()
}

class DBManager: ManagedObjectConvertible {
    
    var delegate: AnswersTableViewController?
    
    private var itemArray = [Item]()
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) -> [Item] {
        do {
            itemArray = try context.fetch(request)
            reloadTableView()
            return itemArray
        } catch {
            fatalError("Error loading items \(error)")
        }
        
    }
    
    func deleteItem(at indexPath: IndexPath) {
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        
        saveItems()
    }
    
    func saveItems() {
        do {
            try context.save()
            reloadTableView()
        } catch {
            print("Error saving context, \(error)")
        }
    }
    
    func reloadTableView() {
        if let viewController = delegate {
            viewController.reloadTableView()
        }
    }
    
}
