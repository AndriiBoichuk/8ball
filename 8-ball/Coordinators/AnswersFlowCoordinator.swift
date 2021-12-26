//
//  AnswersFlowCoordinator.swift
//  8-ball
//
//  Created by Андрій Бойчук on 20.12.2021.
//

import UIKit

class AnswersFlowCoordinator: NavigationNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let dbManager: DBManager
    
    init(parent: NavigationNode, dbManager: DBManager) {
        self.dbManager = dbManager
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let model = AnswersModel(dbManager)
        let viewModel = AnswersViewModel(model)
        let answersTVC = AnswersTableViewController(viewModel)
        
        answersTVC.tabBarItem = UITabBarItem(title: L10n.Tabbar.title2, image: UIImage(systemName: L10n.Image.tabIcon2), tag: 1)
        containerViewController = answersTVC
        
        return answersTVC
    }
    
}
