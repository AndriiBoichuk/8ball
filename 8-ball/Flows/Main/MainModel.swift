//
//  MainModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 13.11.2021.
//

import Foundation
import KeychainSwift

class MainModel {
    
    private var itemArray = [Item]()
    private let keychainManager: KeychainManager
    private let databaseManager: DBManager
    private let connectionManager: ConnectionManager
    private let answerManager: AnswerManager
    
    init(_ dbManager: DBManager, _ connectionManager: ConnectionManager, _ answerManager: AnswerManager, _ keychainManger: KeychainManager) {
        self.databaseManager = dbManager
        self.connectionManager = connectionManager
        self.answerManager = answerManager
        self.keychainManager = keychainManger
        
        setConnectionStatus()
    }
    
    func getDBManager() -> DBManager {
        return databaseManager
    }
    
    private func setConnectionStatus() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(connectionManager.statusManager),
                         name: .flagsChanged,
                         object: nil)
        connectionManager.updateConnectionStatus()
    }
    
    func getAnswer(completion: @escaping ((Answer) -> Void)) {
        var answer = Answer(answer: "", type: nil)
        if connectionManager.isInternetConnection {
            answerManager.getAnswer { magic, error in
                if let safeMagic = magic {
                    answer = safeMagic.toAnswer()
                    completion(answer)
                } else {
                    print(error ?? "Error loading")
                }
            }
        } else {
            if itemArray.count == 0 {
                answer = Answer(answer: L10n.Error.Internet.title, type: nil)
            } else {
                let hardcodedAnswer = itemArray[Int.random(in: 0..<itemArray.count)].hardcodedAnswer!
                answer = Answer(answer: hardcodedAnswer, type: nil)
            }
            completion(answer)
        }
    }
    
    func loadItems() {
        itemArray = databaseManager.loadItems()
    }
    
    func getQuantity() -> Int {
        keychainManager.getCount()
    }
    
    func addAnswer(_ answer: String) {
        if !checkRepetition(at: answer) {
            let newItem = Item(context: databaseManager.context)
            newItem.hardcodedAnswer = answer
            newItem.date = Date().timeIntervalSince1970

            databaseManager.addItem(newItem)
        }
    }
    
    private func checkRepetition(at str: String) -> Bool {
        for item in itemArray where item.hardcodedAnswer == str {
            return true
        }
        return false
    }
    
}
