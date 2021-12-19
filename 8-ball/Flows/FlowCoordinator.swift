//
//  FlowCoordinator.swift
//  8-ball
//
//  Created by Андрій Бойчук on 19.12.2021.
//

import UIKit
import Swinject

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let dbManager: DBManager

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.dbManager = DBManager()
    }

    func start() {
        let connectionManager = ConnectionManager()
        let answerManager = AnswerManager()
        let keychainManager = KeychainManager()
        let model = MainModel(dbManager, connectionManager, answerManager, keychainManager)
        let viewModel = MainViewModel(model)
        
        let mainVC = MainViewController(viewModel)
        mainVC.coordinator = self
        
        navigationController.pushViewController(mainVC, animated: false)
    }
    
    func showSettings() {
        let model = SettingsModel(dbManager)
        let viewModel = SettingsViewModel(model)
        let settingsVC = SettingsViewController(viewModel)
        settingsVC.coordinator = self
        navigationController.pushViewController(settingsVC, animated: true)
    }
}
