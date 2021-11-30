//
//  MainTabBarController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 26.11.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    private let dbManager = DBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .black
        
        viewControllers = [createMainNC(), createAnswersTVC()]
    }
    
    private func createMainNC() -> UINavigationController {
        let connectionManager = ConnectionManager()
        let answerManager = AnswerManager()

        let keychainManager = KeychainManager()
        
        let model = MainModel(dbManager, connectionManager, answerManager, keychainManager)
        
        let viewModel = MainViewModel(model)
        
        let rootViewController = MainViewController(viewModel)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem = UITabBarItem(title: L10n.Tabbar.title1, image: UIImage(systemName: L10n.Image.tabIcon1), tag: 0)
        
        return navigationController
    }
    
    private func createAnswersTVC() -> AnswersTableViewController {
        let model = AnswersModel(dbManager)
        let viewModel = AnswersViewModel(model)
        let answersTVC = AnswersTableViewController(viewModel)
        
        answersTVC.tabBarItem = UITabBarItem(title: L10n.Tabbar.title2, image: UIImage(systemName: L10n.Image.tabIcon2), tag: 1)
        
        return answersTVC
    }
    
}
