//
//  ViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 24.09.2021.
//

import UIKit
import CoreData
import CLTypingLabel

class ViewController: UIViewController {

    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let connectionManager = ConnectionManager()
    
    var answerManager = AnswerManager()
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        titleLabel.text = "Shake the device"
        
        loadItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder() // To get shake gesture

        answerManager.delegate = self
        
        // Check internet connection
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(connectionManager.statusManager),
                         name: .flagsChanged,
                         object: nil)
        
        connectionManager.updateConnectionStatus()
    }
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    // MARK: - Enable detection of shake motion
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            titleLabel.text = "Shaking the device"
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if connectionManager.isInternetConnection {
                answerManager.getAnswer(for: "Example")
            } else {
                if itemArray.count == 0 {
                    titleLabel.text = "Check Internet"
                } else {
                    titleLabel.text = itemArray[Int.random(in: 0..<itemArray.count)].hardcodedAnswer
                }
            }
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        titleLabel.text = "Motion cancelled"
    }
    
    // MARK: - Data Manipulation Methods
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error loading items \(error)")
        }
    }
}

// MARK: - AnswerDelegate

extension ViewController: AnswerDelegateProtocol {
    
    func responseReceived(answer: String) {
        titleLabel.text = answer
    }
    
    func didFailWithError(error: Error) {
        titleLabel.text = itemArray[Int.random(in: 0..<itemArray.count)].hardcodedAnswer
    }
}
