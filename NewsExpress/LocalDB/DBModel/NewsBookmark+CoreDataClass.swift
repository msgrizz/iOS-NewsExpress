//
//  ProjectMain+CoreDataClass.swift
//  
//
//  Created by Macbook on 19/06/18.
//  Copyright © 2018 Ozoprop Technologies Pvt Ltd. All rights reserved.//
//

import Foundation
import CoreData

@objc(NewsBookmark)
public class NewsBookmark: NSManagedObject {

    func populateFrom(news: News) {
       
        self.author = news.author
        self.title = news.title
        self.publishedAt = news.publishedAt
        self.newsDescription = news.description
        self.url = news.url
        self.urlToImage = news.urlToImage
    }
}
