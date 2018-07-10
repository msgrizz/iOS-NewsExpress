//
//  Profile.swift
//  Partner
//
//  Created by Subhajit Halder on 01/05/18.
//  Copyright © 2018 Ozoprop Technologies Pvt Ltd. All rights reserved.
//

import Foundation

struct News {
    
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    
    init() {
        author = ""
        title = ""
        description = ""
        url = ""
        urlToImage = ""
        publishedAt = ""
    }
    
    init(dict: NSDictionary) {
        author = dict.toStringFrom(key: "author")
        title = dict.toStringFrom(key: "title")
        description = dict.toStringFrom(key: "description")
        url = dict.toStringFrom(key: "url")
        urlToImage = dict.toStringFrom(key: "urlToImage")
        publishedAt = dict.toStringFrom(key: "publishedAt")
    }
    
    func getRequestForNewsList(vc: HomeVC) -> [String: String]! {
        
        if vc.source == "" {
            let dict = [
                "country": "us",
                "category": "business",
                "apiKey": GlobalConstants.apiKey
            ]
            return dict
        } else {
            let dict = [
                "sources": vc.source,
                "apiKey": GlobalConstants.apiKey
            ]
            return dict
        }
    }
}

struct Source {
    
    let id: String
    let name: String
    
    init(dict: NSDictionary) {
        id = dict.toStringFrom(key: "id")
        name = dict.toStringFrom(key: "name")
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
