//
//  SHReachabilityManager.swift
//  SHRestClientExample
//
//  Created by subhajit halder on 24/07/17.
//  Copyright © 2017 SubhajitHalder. All rights reserved.
//

import UIKit
//import Reachability

public protocol SHReachabilityManagerDelegate: class {
//    func networkStatusDidChange(status: Reachability.connection)
}

class SHReachabilityManager: NSObject {
//
//    static let shared = SHReachabilityManager()
//
//
//
//    var reachabilityStatus : Reachability.connection = .notReachable
//
//    let reachability = Reachability()!
//
//    var listeners = [SHReachabilityManagerDelegate]()
//
//    var isNetworkAvailable: Bool {
//
//        return self.reachabilityStatus != .notReachable
//
//    }
//
//    func addListner(listener: SHReachabilityManagerDelegate) {
//        listeners.append(listener)
//    }
//
//    func removeListener(listener: SHReachabilityManagerDelegate) {
//        listeners = listeners.filter{$0 !== listener}
//    }
//
//
//
//    @objc func reachabilityChanged(_ notification: Notification) {
//
//        let reachability = notification.object as! Reachability
//
//        switch reachability.currentReachabilityStatus {
//        case .notReachable:
//            break
//        //
//        case .reachableViaWiFi: break
//        case .reachableViaWWAN: break
//        }
//
//        self.reachabilityStatus = reachability.currentReachabilityStatus
//
//        for listener in listeners {
//            listener.networkStatusDidChange(status: reachability.currentReachabilityStatus)
//        }
//    }
//
//    func startMonitoring() {
//        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
//
//        do {
//
//            try reachability.startNotifier()
//
//        } catch {
//
//            debugPrint("Could not start reachability notifier")
//
//        }
//    }
//
//    func stopMonitoring() {
//        reachability.stopNotifier()
//        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
//    }
//
}

