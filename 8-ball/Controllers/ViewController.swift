//
//  ViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 24.09.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var isInternetConnection: Bool = true
    
    var answerManager = AnswerManager()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        loadItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder() // To get shake gesture

        answerManager.delegate = self
        
        // Check internet connection
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        
        updateConnectionStatus()
    }
    
    // MARK: - Check Internet Connection
    @objc func statusManager(_ notification: Notification) {
        updateConnectionStatus()
    }
    
    func updateConnectionStatus() {
        isInternetConnection =  Network.reachability.status == .unreachable ? false : true
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
            if isInternetConnection {
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
