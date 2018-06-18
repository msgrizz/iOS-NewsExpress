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

class NewsUpdates {
    
    var author : String?
    var title : String?
    var description : String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
    init(author: String, title: String, description: String, url: String, urlToImage: String, publishedAt : String) {
        
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}