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
        if let countStr = keychain.get(key.rawValue) {
            if var count = Int(countStr) {
                count += 1
                keychain.set(String(count), forKey: key.rawValue)
                return count
            } else {
                return 0
            }
        } else {
            keychain.set("0", forKey: key.rawValue)
            return 0
        }
    }
    
}
