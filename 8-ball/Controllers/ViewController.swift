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

    private var itemArray = [Item]()

    private let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private var connectionManager: ConnectionManager!
    private var answerManager: AnswerManager!

    @IBOutlet weak var titleLabel: CLTypingLabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear

        titleLabel.text = L10n.shake

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

    init?(coder: NSCoder, connectionManager: ConnectionManager, answerManager: AnswerManager) {
        self.connectionManager = connectionManager
        self.answerManager = answerManager
        super.init(coder: coder)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
            titleLabel.text = L10n.shake
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
        titleLabel.text = L10n.canceled
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

// MARK: - Data Manipulation Methods

extension ViewController: ManagedObjectConvertible {

    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error loading items \(error)")
        }
    }

    func deleteItem(at indexPath: IndexPath) {
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)

        saveItems()
    }

    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
    }

}
