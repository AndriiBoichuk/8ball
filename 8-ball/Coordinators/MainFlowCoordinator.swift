//
//  MainFlowCoordinator.swift
//  8-ball
//
//  Created by Андрій Бойчук on 20.12.2021.
//

import UIKit

enum MainEvent: NavigationEvent {
    
    case settings
    
}

class MainFlowCoordinator: NavigationNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let dbManager: DBManager
    
    init(parent: NavigationNode, dbManager: DBManager) {
        self.dbManager = dbManager
        super.init(parent: parent)
        
        addHandlers()
    }
    
    private func addHandlers() {
        addHandler { [weak self] (event: MainEvent) in
            guard let self = self else { return }
            switch event {
            case .settings:
                self.showSettings()
            }
        }
    }
    
    func createFlow() -> UIViewController {
        let connectionManager = ConnectionManager()
        let answerManager = AnswerManager()
        let keychainManager = KeychainManager()
        let model = MainModel(dbManager, connectionManager, answerManager, keychainManager, self)
        let viewModel = MainViewModel(model)
        let mainVC = MainViewController(viewModel)
        
        mainVC.tabBarItem = UITabBarItem(title: L10n.Tabbar.title1, image: UIImage(systemName: L10n.Image.tabIcon1), tag: 0)
        containerViewController = mainVC
        
        return mainVC
    }
    
    func showSettings() {
        let settingsFC = SettingsFlowCoordinator(parent: self, dbManager: dbManager)
        let settingsVC = settingsFC.createFlow()
        settingsFC.containerViewController = settingsVC
        
        containerViewController?.navigationController!.pushViewController(settingsVC, animated: true)
    }
    
}
