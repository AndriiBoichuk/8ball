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
    
    func getQuantity() -> Int {
        keychainManager.getCount()
    }
    
}
