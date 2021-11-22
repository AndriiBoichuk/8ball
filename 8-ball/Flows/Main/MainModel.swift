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
    private var keychain = KeychainSwift()
    private var databaseManager: DBManager!
    private var connectionManager: ConnectionManager!
    private var answerManager: AnswerManager!
    
    init(_ dbManager: DBManager, _ connectionManager: ConnectionManager, _ answerManager: AnswerManager) {
        self.databaseManager = dbManager
        self.connectionManager = connectionManager
        self.answerManager = answerManager
        
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
    
    func getAnswer() -> Answer {
        var answer = Answer(answer: "", type: nil)
        if connectionManager.isInternetConnection {
            answerManager.getAnswer { magic, error in
                if let safeMagic = magic {
                    answer = safeMagic.toAnswer()
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
        } 
        return answer
    }
    
    func loadItems() {
        itemArray = databaseManager.loadItems()
    }
    
    func updateCounter() -> Int {
        if let countStr = keychain.get("key") {
            if var count = Int(countStr) {
                count += 1
                keychain.set(String(count), forKey: "key")
                return count
            } else {
                return 0
            }
        } else {
            keychain.set("0", forKey: "key")
            return 0
        }
    }
    
}
