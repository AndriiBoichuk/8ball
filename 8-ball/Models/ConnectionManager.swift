//
//  ConnectionManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 05.11.2021.
//

import Foundation

class ConnectionManager {
    var isInternetConnection: Bool = true
    
    // MARK: - Check Internet Connection
    @objc func statusManager(_ notification: Notification) {
        updateConnectionStatus()
    }
    
    func updateConnectionStatus() {
        isInternetConnection =  Network.reachability.status == .unreachable ? false : true
    }
    
}
