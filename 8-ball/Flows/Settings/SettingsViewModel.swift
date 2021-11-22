//
//  SettingsViewModel.swift
//  8-ball
//
//  Created by Андрій Бойчук on 14.11.2021.
//

import Foundation

class SettingsViewModel {
    
    var settingsModel: SettingsModel
    
    init(_ model: SettingsModel) {
        self.settingsModel = model
    }
    
    func addAnswer(_ answer: String) {
        settingsModel.addItem(answer)
    }
    
    func loadItems() {
        settingsModel.loadItems()
    }
    
}
