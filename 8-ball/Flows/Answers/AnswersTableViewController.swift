//
//  AnswersTableViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 12.10.2021.
//

import UIKit
import CoreData

class AnswersTableViewController: UIViewController {
    
    private let answersViewModel: AnswersViewModel
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        loadViews()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        answersViewModel.loadItems()
        tableView.reloadData()
    }
    
    init(_ viewModel: AnswersViewModel) {
        self.answersViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: L10n.Cell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(asset: Asset.colorBrand)
        tableView.rowHeight = 50
        tableView.separatorColor = .gray
    }
    
}

// MARK: - TableView Datasource Methods

extension AnswersTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answersViewModel.countArray()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.Cell.identifier, for: indexPath)
        
        let item = answersViewModel.getItem(at: indexPath)
        cell.textLabel?.text = item.hardcodedAnswer
        cell.backgroundColor = UIColor(asset: Asset.colorBrand)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {

            answersViewModel.deleteItem(at: indexPath)
            answersViewModel.loadItems()
            tableView.reloadData()
        }
    }
}

// MARK: - Search Bar Methods

extension AnswersTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        answersViewModel.loadItems(with: searchBar.text!)
        tableView.reloadData()
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

private extension AnswersTableViewController {
    
    func loadViews() {
        view.backgroundColor = UIColor(asset: Asset.colorBrand)
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}
