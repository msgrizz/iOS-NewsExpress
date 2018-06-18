//
//  HomeVC+API.swift
//  NewsExpress
//
//  Created by Macbook on 06/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation

extension HomeVC {
    
    func callTopHeadlines(params:[String: String], done: @escaping (_ newsList: [News])->()) {
        APIManager.getNewsList(params: params, success: { (newsList) in
            done(newsList)
        }) { (errMsg) in
            print(errMsg)
        }
    }
}
