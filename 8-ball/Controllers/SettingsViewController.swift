//
//  SettingsViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 28.09.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var saveButtonView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: K.fontName, size: 25)!
        ]
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        saveButtonView.layer.cornerRadius = 10
        saveButtonView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        answerTextField.layer.cornerRadius = 10
        answerTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        if answerTextField.text == "" {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        if let safeAnswers = defaults.array(forKey: K.userDefaultsKey) as? [String] {
            K.answers.append(contentsOf: safeAnswers)
        }
    }
    
    
    @IBAction func saveTouched(_ sender: UIButton) {
        if let answer = answerTextField.text {
            K.answers.append(answer)
        }
        answerTextField.text = ""
        defaults.set(K.answers, forKey: K.userDefaultsKey)
    }
    
}
