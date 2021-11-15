//
//  ViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 24.09.2021.
//

import UIKit
import CoreData
import CLTypingLabel

class MainViewController: UIViewController {

    private var itemArray = [Item]()

    private var databaseManager: DBManager!
    private var connectionManager: ConnectionManager!
    private var answerManager: AnswerManager!
    
    @IBOutlet weak var titleLabel: CLTypingLabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear

        itemArray = databaseManager.loadItems()

        titleLabel.text = L10n.Shake.title
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

    init?(coder: NSCoder, connectionManager: ConnectionManager, answerManager: AnswerManager, dbManager: DBManager) {
        self.connectionManager = connectionManager
        self.answerManager = answerManager
        self.databaseManager = dbManager
        super.init(coder: coder)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SettingsViewController else { return }
        destination.setDatabaseManager(dbManager: databaseManager)
    }
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
            return true
    }

    // MARK: - Enable detection of shake motion

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            titleLabel.text = L10n.Shake.title
        }
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if connectionManager.isInternetConnection {
                answerManager.getAnswer(for: "Example")
            } else {
                if itemArray.count == 0 {
                    titleLabel.text = L10n.Error.Internet.title
                } else {
                    titleLabel.text = itemArray[Int.random(in: 0..<itemArray.count)].hardcodedAnswer
                }
            }
        }
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        titleLabel.text = L10n.Canceled.Error.title
    }

}

// MARK: - AnswerDelegate

extension MainViewController: AnswerDelegateProtocol {

    func responseReceived(answer: String) {
        titleLabel.text = answer
    }

    func didFailWithError(error: Error) {
        titleLabel.text = itemArray[Int.random(in: 0..<itemArray.count)].hardcodedAnswer
    }
}
