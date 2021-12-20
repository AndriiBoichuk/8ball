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
        
        let appCoordinator = AppCoordinator()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = appCoordinator.createFlow()
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
    }
    
}
