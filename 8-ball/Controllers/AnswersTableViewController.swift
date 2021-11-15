//
//  AnswersTableViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 12.10.2021.
//

import UIKit
import CoreData

class AnswersTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    var itemArray = [Item]()
    
    private var databaseManager: DBManager!
    
    func setDatabaseManager(dbManager: DBManager) {
        self.databaseManager = dbManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self

        databaseManager.delegate = self
        
        tableView.rowHeight = 50

        tableView.separatorColor = .gray
        
        itemArray = databaseManager.loadItems()
    }

    // MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.Cell.identifier, for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row].hardcodedAnswer

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            databaseManager.deleteItem(at: indexPath)
        }
    }

}

// MARK: - Search Bar Methods

extension AnswersTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let request: NSFetchRequest<Item> = Item.fetchRequest()

        let predicate = NSPredicate(format: "hardcodedAnswer CONTAINS[cd] %@", searchBar.text!)

        request.predicate = predicate

        let sortDescriptor = NSSortDescriptor(key: L10n.Key.answer, ascending: true)

        request.sortDescriptors = [sortDescriptor]

        itemArray = databaseManager.loadItems(with: request)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            itemArray = databaseManager.loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

extension AnswersTableViewController: DBDelegateProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}
