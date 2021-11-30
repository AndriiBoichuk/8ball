//
//  ConnectionManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 05.11.2021.
//

import Foundation
import UIKit

final class ConnectionManager {
    
    var isInternetConnection: Bool = true
    private let reachabilityInternet: ReachabilityInternet
    
    init() {
        reachabilityInternet = ReachabilityInternet()
    }
    
    // MARK: - Check Internet Connection
    @objc func statusManager(_ notification: Notification) {
        updateConnectionStatus()
    }

    func updateConnectionStatus() {
        isInternetConnection =  Network.reachability.status == .unreachable ? false : true
    }

}

private class ReachabilityInternet {
    init() {
        do {
            try Network.reachability = Reachability(hostname: "www.google.com")
        } catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
    }
}
