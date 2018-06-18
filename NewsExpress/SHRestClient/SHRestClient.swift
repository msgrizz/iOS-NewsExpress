//
//  SHRestClient.swift
//  SHRestClientExample
//
//  Created by subhajit halder on 19/07/17.
//  Copyright © 2017 SubhajitHalder. All rights reserved.
//

import UIKit
//import Reachability
import SVProgressHUD

typealias SHHTTPResponseBlock = (Any?, HTTPURLResponse?, Error?) -> Void
typealias SHReachabilityErrorBlock = () -> Void
typealias SHErrorBlock = (SHRestClientErrorType,Error?) -> Void
typealias SHSuccessBlock = (Any?, HTTPURLResponse?) -> Void

class SHRestClient: NSObject {
    
    var urlString : String
    
    internal var httpSessionConfiguration: URLSessionConfiguration = .default
    
    var reachabilty: Reachability
    
    var sessionConfiguration: URLSessionConfiguration {
        set {
            self.httpSessionConfiguration = newValue
        }
        get {
            return self.httpSessionConfiguration
        }
    }
    
    init(url: String!) {
        self.urlString = url
        self.reachabilty = Reachability()
    }
    
    override init() {
        self.urlString = ""
        self.reachabilty = Reachability()
    }
    
    
    
    func get(parameters: [String: String]?, headers: [String: String]?, success: @escaping SHSuccessBlock, faliure: @escaping SHErrorBlock) {
        
        proceedFetchingWith(method: "GET", parameters: parameters, headers: headers, success: success, faliure: faliure)
        
    }
    
    func post(parameters: [String:String], headers: [String:String]?, success: @escaping SHSuccessBlock, faliure: @escaping SHErrorBlock) {
        
        proceedFetchingWith(method: "POST", parameters: parameters, headers: headers, success: success, faliure: faliure)
        
    }
    
    func post(parameters: [String:Any], headers: [String:String]?, success: @escaping SHSuccessBlock, faliure: @escaping SHErrorBlock) {
        
        proceedFetchingWith(method: "POST", parameters: parameters, headers: headers, success: success, faliure: faliure)
        
    }
    
    func delete(parameters: [String: String]?, headers: [String: String]?, success: @escaping SHSuccessBlock, faliure: @escaping SHErrorBlock) {
        
        proceedFetchingWith(method: "DELETE", parameters: parameters, headers: headers, success: success, faliure: faliure)
        
    }
    
    func put(parameters: [String: String]?, headers: [String: String]?, success: @escaping SHSuccessBlock, faliure: @escaping SHErrorBlock) {
        proceedFetchingWith(method: "PUT", parameters: parameters, headers: headers, success: success, faliure: faliure)
    }
       
    
}

extension SHRestClient: SHReachabilityManagerDelegate {
    
//    func networkStatusDidChange(status: Reachability.NetworkStatus) {
//
//        if status == .notReachable {
//            // TODO: Present a reachability view controller in current window
//            let topVC = AppDelegate.getTopViewController()
//            guard let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main) as? UIStoryboard else { return }
//
//            guard let reachabilityVC = storyBoard.instantiateViewController(withIdentifier: "") as? UIViewController else { return }
//
//            topVC?.showReachabilityAlert()
//
//
//        } else {
//
//
//            //TODO: Dissmiss the reachability controller
//
//        }
    
        
    }
    

