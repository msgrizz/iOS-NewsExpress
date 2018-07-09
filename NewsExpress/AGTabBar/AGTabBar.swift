//
//  AGTabBar.swift
//  NewsExpress
//
//  Created by Macbook on 10/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class AGTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
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
        let home = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home-normal"), selectedImage: #imageLiteral(resourceName: "home-selected"))
        homeVC.tabBarItem = home
        
        // Create Tab two
        let stocksVC = StockVC()
        let stocks = UITabBarItem(title: "Bookmark", image: #imageLiteral(resourceName: "bookmark-normal"), selectedImage: #imageLiteral(resourceName: "bookmark-selected"))
        stocksVC.tabBarItem = stocks
        
        // Create Tab three
        let quoteVC = QuoteVC()
        let quote = UITabBarItem(title: "Quote", image: #imageLiteral(resourceName: "quote-normal"), selectedImage: #imageLiteral(resourceName: "quote-selected"))
        quoteVC.tabBarItem = quote
        
        // Create Tab four
        let moreVC2 = MoreVC()
        let more2 = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "more-normal"), selectedImage: #imageLiteral(resourceName: "more-selected"))
        moreVC2.tabBarItem = more2
        
        self.viewControllers = [homeVC, stocksVC, quoteVC, moreVC2]
        
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
