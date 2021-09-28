//
//  SettingsViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 28.09.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Rockwell", size: 25)!
        ]
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
