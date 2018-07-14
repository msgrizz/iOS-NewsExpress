//
//  GlobalConstants.swift
//  Partner
//
//  Created by Subhajit Halder on 08/05/18.
//  Copyright 2018 Ozoprop Technologies Pvt Ltd. All rights reserved.
//

import Foundation

enum GlobalConstants {
    static let baseUrl = "https://newsapi.org/v2/"
    static let apiKey = "Your_API_Key"
    static let basePath = ""
}

enum Constraints {
    static let cMaxProjectFreeUserCanSelect = 3
    static let cMaxProjectPaidUserCanSelect = 10
    static let cMaxLocationUserCanOperate = 5
}

extension UserDefaults {
    enum Keys {
        static let isDisplayLogIn = "isDisplayLogIn"
    }
}
