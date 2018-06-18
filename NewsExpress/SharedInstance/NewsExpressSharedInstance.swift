//
//  GetProjectSharedInstance.swift
//  Partner
//
//  Created by Shree Ganesh on 2/4/18.
//  Copyright © 2018 Ozoprop Technologies Pvt Ltd. All rights reserved.
//

import Foundation

class NewsExpressSharedInstance {
    
    var title : String = ""
    
    class var newsExpressSharedInstance: NewsExpressSharedInstance {
        struct Static {
            static let instance: NewsExpressSharedInstance = NewsExpressSharedInstance()
        }
        return Static.instance
    }
}
