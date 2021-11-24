//
//  KeychainManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 23.11.2021.
//

import Foundation
import KeychainSwift

class KeychainManager {
    
    private var keychain = KeychainSwift()
    
    func getCount() -> Int {
        let key: StorageKey = .key
        if let countStr = getValue(for: key) {
            if var count = Int(countStr) {
                count += 1
                set(value: String(count), for: key)
                return count
            } else {
                return 0
            }
        } else {
            set(value: "0", for: key)
            return 0
        }
    }
    
    private func set(value: String, for key: StorageKey) {
        keychain.set(value, forKey: key.rawValue)
    }
    
    private func getValue(for key: StorageKey) -> String? {
        keychain.get(key.rawValue)
    }
    
}
