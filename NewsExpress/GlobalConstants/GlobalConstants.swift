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
    static let apiKey = "b74b17391266429d846c1d4d6c29299e"
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
