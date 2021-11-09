//
//  SettingsViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 28.09.2021.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    var itemArray = [Item]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var saveButtonView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: K.fontName, size: 22)!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerTextField.delegate = self
        
        saveButton.isEnabled = false
        
        loadItems()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        turnOffButtonPressed()
    }
    
    @IBAction func saveTouched(_ sender: UIButton) {
        if let answer = answerTextField.text {
            let newItem = Item(context: context)
            newItem.hardcodedAnswer = answer
            itemArray.append(newItem)
            
            saveButton.isEnabled = false
            saveItems()
        }
        answerTextField.text = ""
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error loading items \(error)")
        }
    }
    
    func turnOffButtonPressed() {
        if answerTextField.text == "" {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
}

// MARK: - TextField Delegate

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let answer = answerTextField.text {
            let newItem = Item(context: context)
            newItem.hardcodedAnswer = answer
            itemArray.append(newItem)
            
            saveItems()
        }
        answerTextField.text = ""
        
        turnOffButtonPressed()
        return true
    }
}
