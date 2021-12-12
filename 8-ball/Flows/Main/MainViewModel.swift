//
//  MainViewModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 13.11.2021.
//

import Foundation
import RxSwift

class MainViewModel {
    
    var mainModel: MainModel
    
    private let disposeBag = DisposeBag()
    
    init(_ model: MainModel) {
        self.mainModel = model
    }
    
    func getPresentableAnswer() -> Observable<PresentableAnswer> {
//        var presentAnswer = PresentableAnswer(answer: "")
        return Observable.create {observer in
            self.mainModel.getAnswer()
                .observe(on: MainScheduler.asyncInstance)
                .subscribe { answer in
                    observer.on(.next(answer.toPresentableAnswer()))
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func loadItems() {
        mainModel.loadItems()
    }
    
    func getQuantity() -> String {
        return String(mainModel.getQuantity())
    }
    
    func addAnswer(_ answer: String) {
        mainModel.addAnswer(answer)
    }
    
    func setConnectionStatus() {
        mainModel.setConnectionStatus()
    }
    
}
