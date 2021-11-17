//
//  AnswersTableViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 12.10.2021.
//

import UIKit
import CoreData

class AnswersTableViewController: UITableViewController {

    var answersViewModel: AnswersViewModel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        tableView.rowHeight = 50
        tableView.separatorColor = .gray
        
        answersViewModel.loadItems()
    }
    
    func setAnswersViewModel(_ viewModel: AnswersViewModel) {
        self.answersViewModel = viewModel
    }

    // MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answersViewModel.countArray()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.Cell.identifier, for: indexPath)
        
        let item = answersViewModel.getItem(at: indexPath)
        cell.textLabel?.text = item.hardcodedAnswer
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            answersViewModel.deleteItem(at: indexPath)
            reloadTableView()
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }

}

// MARK: - Search Bar Methods

extension AnswersTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        answersViewModel.loadItems(with: searchBar.text!)
        reloadTableView()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            answersViewModel.loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
