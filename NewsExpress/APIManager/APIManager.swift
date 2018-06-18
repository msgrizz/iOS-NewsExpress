//
//  APIManager.swift
//  Partner
//
//  Created by Subhajit Halder on 01/05/18.
//  Copyright © 2018 Ozoprop Technologies Pvt Ltd. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    
    class func getNewsList( params: [String: String], success: @escaping (_ newsList: [News])->(), failure: @escaping (_ errorMessage: String)->()) {
        
        let url = GlobalConstants.baseUrl + "top-headlines?country=us&" + GlobalConstants.apiKey
        
        let restClient = SHRestClient(url: url)
        
        restClient.get(parameters: params, headers: nil, success: { (data, response) in
            
            if let object = data as? [String: Any] {
                if object["status"] as? String == "ok" {
                    if let articlesArr = object["articles"] as? [[String: Any]] {
                        
                        var newsList = [News]()
                        
                        for obj in articlesArr {
                            let newNews = News(dict: obj as NSDictionary)
                            newsList.append(newNews)
                        }
                        success(newsList)
                    } else {
                        failure("Response is not Array")
                    }
                } else {
                    failure("Status is not ok")
                }
            } else {
                failure("Data is not a Dictionary")
            }
        }) { (type, error) in
            failure("Data cannot be parsed as JSON")
        }
    }
}
