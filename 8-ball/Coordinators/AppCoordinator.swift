//
//  AppCoordinator.swift
//  8-ball
//
//  Created by Андрій Бойчук on 20.12.2021.
//

import UIKit

protocol FlowCoordinator: AnyObject {
    // this variable must only be of 'weak' type
    var containerViewController: UIViewController? { get set }

    @discardableResult
    func createFlow() -> UIViewController
}

class AppCoordinator: NavigationNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let dbManager = DBManager()
    
    init() {
        super.init(parent: nil)
    }
    
    func createFlow() -> UIViewController {
        let mainFC = MainFlowCoordinator(parent: self, dbManager: dbManager)
        let mainVC = mainFC.createFlow()
        mainFC.containerViewController = mainVC
        
        let answersFC = AnswersFlowCoordinator(parent: self, dbManager: dbManager)
        let answersVC = answersFC.createFlow()
        answersFC.containerViewController = answersVC
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [UINavigationController(rootViewController: mainVC), answersVC]
        tabBarVC.tabBar.tintColor = .black
        
        return tabBarVC
    }
    
}
