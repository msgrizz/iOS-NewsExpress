//
//  AGTabBar.swift
//  NewsExpress
//
//  Created by Macbook on 10/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class AGTabBar: UITabBarController {
    
    var source = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupTabBar()
    }
    
    func setupTabBar() {
        
        UITabBar.appearance().tintColor = UIColor(hex: "424242")
        
        // Create Tab one
        let homeVC = HomeVC()
        let home = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home-normal"), selectedImage: #imageLiteral(resourceName: "home-selected-blue"))
        homeVC.tabBarItem = home
        homeVC.source = self.source
        
        // Create Tab two
        let bookmarkVC = BookmarkVC()
        let bookmark = UITabBarItem(title: "Bookmark", image: #imageLiteral(resourceName: "bookmark-normal"), selectedImage: #imageLiteral(resourceName: "bookmark-selected"))
        bookmarkVC.tabBarItem = bookmark
        
        // Create Tab three
        let quoteVC = QuoteVC()
        let quote = UITabBarItem(title: "Quote", image: #imageLiteral(resourceName: "quote-normal"), selectedImage: #imageLiteral(resourceName: "quote-selected-blue"))
        quoteVC.tabBarItem = quote
        
        // Create Tab four
        let moreVC2 = MoreVC()
        let more2 = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "more-normal"), selectedImage: #imageLiteral(resourceName: "more-selected-blue"))
        moreVC2.tabBarItem = more2
        
        self.viewControllers = [homeVC, bookmarkVC, quoteVC, moreVC2]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0)
        }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor(hex: "9e9e9e")], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor(hex: "424242")], for: .selected)
    }
}

extension AGTabBar: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
