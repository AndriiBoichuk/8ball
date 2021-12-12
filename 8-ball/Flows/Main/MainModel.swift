//
//  MainModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 13.11.2021.
//

import Foundation
import KeychainSwift
import RxSwift

class MainModel {
    
    private let keychainManager: KeychainManager
    private let databaseManager: DBManager
    private let connectionManager: ConnectionManager
    private let answerManager: AnswerManager
    
    private let disposeBag = DisposeBag()
    
    init(_ dbManager: DBManager, _ connectionManager: ConnectionManager, _ answerManager: AnswerManager, _ keychainManger: KeychainManager) {
        self.databaseManager = dbManager
        self.connectionManager = connectionManager
        self.answerManager = answerManager
        self.keychainManager = keychainManger
    }
    
    func getDBManager() -> DBManager {
        return databaseManager
    }
    
    func setConnectionStatus() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(connectionManager.statusManager),
                         name: .flagsChanged,
                         object: nil)
        connectionManager.updateConnectionStatus()
    }
    
    func getAnswer() -> Observable<Answer> {
        return Observable.create { observer in
            var answer = Answer(answer: "", type: nil)
            if self.connectionManager.isInternetConnection {
                self.answerManager.getAnswer()
                    .observe(on: MainScheduler.asyncInstance)
                    .subscribe { answerData in
                        observer.on(.next(answerData.toAnswer()))
                    } onError: { (error) in
                        print(error)
                    }
                    .disposed(by: self.disposeBag)
                return Disposables.create()
            } else {
                if self.databaseManager.getCount() == 0 {
                    answer = Answer(answer: L10n.Error.Internet.title, type: nil)
                } else {
                    let index = Int.random(in: 0..<self.databaseManager.getCount())
                    let hardcodedAnswer = self.databaseManager.getItem(at: index).hardcodedAnswer!
                    answer = Answer(answer: hardcodedAnswer, type: nil)
                }
                observer.on(.next(answer))
                return Disposables.create()
            }
        }
    }
    
    func loadItems() {
        databaseManager.loadItems()
    }
    
    func getQuantity() -> Int {
        keychainManager.getCount()
    }
    
    func addAnswer(_ answer: String) {
        if !checkRepetition(at: answer) {
            let newItem = Item(context: databaseManager.getContext())
            newItem.hardcodedAnswer = answer
            newItem.date = Date().timeIntervalSince1970
            
            databaseManager.addItem(newItem)
        }
    }
    
    
    private func checkRepetition(at str: String) -> Bool {
        return databaseManager.checkRepetiton(at: str)
    }
    
}
