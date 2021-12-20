//
//  MainFlowCoordinator.swift
//  8-ball
//
//  Created by Андрій Бойчук on 20.12.2021.
//

import UIKit

class MainFlowCoordinator: NavigationNode, FlowCoordinator {
    weak var containerViewController: UIViewController?
    private let dbManager: DBManager
    
    init(parent: NavigationNode, dbManager: DBManager) {
        self.dbManager = dbManager
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let connectionManager = ConnectionManager()
        let answerManager = AnswerManager()
        let keychainManager = KeychainManager()
        let model = MainModel(dbManager, connectionManager, answerManager, keychainManager)
        let viewModel = MainViewModel(model)
        let mainVC = MainViewController(viewModel)
        mainVC.coordinator = self
        
        mainVC.tabBarItem = UITabBarItem(title: L10n.Tabbar.title1, image: UIImage(systemName: L10n.Image.tabIcon1), tag: 0)
        
        return mainVC
    }
    
    func showSettings() {
        let settingsFC = SettingsFlowCoordinator(parent: self, dbManager: dbManager)
        let settingsVC = settingsFC.createFlow()
        settingsFC.containerViewController = settingsVC
        
        containerViewController?.navigationController!.pushViewController(settingsVC, animated: true)
    }
    
}
