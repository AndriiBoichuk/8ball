//
//  SettingsFlowCoordinator.swift
//  8-ball
//
//  Created by Андрій Бойчук on 20.12.2021.
//

import UIKit

class SettingsFlowCoordinator: NavigationNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let dbManager: DBManager
    
    init(parent: NavigationNode, dbManager: DBManager) {
        self.dbManager = dbManager
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let model = SettingsModel(dbManager)
        let viewModel = SettingsViewModel(model)
        let settingsVC = SettingsViewController(viewModel)
        settingsVC.coordinator = self
        
        return settingsVC
    }
    
}
