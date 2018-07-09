//
//  ProjectMain+CoreDataProperties.swift
//  
//
//  Created by Macbook on 19/06/18.
//  Copyright © 2018 Ozoprop Technologies Pvt Ltd. All rights reserved.//
//

import Foundation
import CoreData

extension NewsBookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsBookmark> {
        return NSFetchRequest<NewsBookmark>(entityName: "BookmarkNewsList")
    }

    @NSManaged public var author: String
    @NSManaged public var newsDescription: String
    @NSManaged public var publishedAt: String
    @NSManaged public var title: String
    @NSManaged public var url: String
    @NSManaged public var urlToImage: String
}
