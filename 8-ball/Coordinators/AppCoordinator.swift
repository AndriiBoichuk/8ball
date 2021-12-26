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

class AppCoordinator: NavigationNode {
    
    private let dbManager = DBManager()
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(parent: nil)
    }
    
    func startFlow() {
        let mainFC = MainFlowCoordinator(parent: self, dbManager: dbManager)
        let mainVC = mainFC.createFlow()
        
        let answersFC = AnswersFlowCoordinator(parent: self, dbManager: dbManager)
        let answersVC = answersFC.createFlow()
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [UINavigationController(rootViewController: mainVC), answersVC]
        tabBarVC.tabBar.tintColor = .black
        
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .light
    }
    
}
