//
//  SceneDelegate.swift
//  8-ball
//
//  Created by Андрій Бойчук on 24.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let connectionManager = ConnectionManager()
        let answerManager = AnswerManager()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let dbManager = DBManager(context: context)
        
        let model = MainModel(dbManager, connectionManager, answerManager)
        let viewModel = MainViewModel(model)
        let rootViewController = MainViewController()
        rootViewController.setMainViewModel(viewModel)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .light
    }
    
}
