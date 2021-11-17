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

        if let windowScene = scene as? UIWindowScene {
            let connectionManager = ConnectionManager()
            let answerManager = AnswerManager()
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let dbManager = DBManager(context: context)
            
            let model = MainModel(dbManager, connectionManager, answerManager)
            let viewModel = MainViewModel(model)
            
            let window = UIWindow(windowScene: windowScene)

            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let viewController = storyboard.instantiateViewController(identifier: "ViewController",
                creator: {coder -> MainViewController? in MainViewController.init(coder: coder)
            })
            viewController.setMainViewModel(viewModel)

            window.rootViewController = UINavigationController.init(rootViewController: viewController)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}
