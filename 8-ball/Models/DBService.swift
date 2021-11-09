//
//  DBService.swift
//  8-ball
//
//  Created by Андрій Бойчук on 05.11.2021.
//



import Foundation
import CoreData

protocol ManagedObjectConvertible {
    func loadItems(with request: NSFetchRequest<Item>) -> [Item]
    func deleteItem(at indexPath: IndexPath)
    func saveItems()
    
}
