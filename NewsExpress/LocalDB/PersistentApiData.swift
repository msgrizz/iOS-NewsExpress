//
//  PersistentApiData.swift
//  Partner
//
//  Created by Macbook on 19/06/18.
//  Copyright © 2018 Ozoprop Technologies Pvt Ltd. All rights reserved.
//

import Foundation

final class PersistantApiData {
    
    var news: [News] = [News]()
    
    struct Static {
        static var instance: PersistantApiData?
    }
    
    class var sharedInstance: PersistantApiData {
        if Static.instance == nil {
            Static.instance = PersistantApiData()
        }
        return Static.instance!
    }
    
    func dispose() {
        PersistantApiData.Static.instance = nil
        print("Disposed Singleton instance")
    }
}
