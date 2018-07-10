//
//  HomeVC.swift
//  NewsExpress
//
//  Created by Macbook on 06/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class HomeVC: UIViewController {
    
    @IBOutlet weak var viewNav: UIView!
    
    @IBOutlet weak var lblNavTitle: UILabel!
    
    @IBOutlet weak var collectionViewForNews: UICollectionView!
    
    var arrNewsData = [News]()
    var newsData = News()
    
    var bookmarkNews = BookmarkNewsList()
    var arrBookmarkNews = [BookmarkNewsList]()
    
    var source = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setData()
        
        self.collectionViewForNews.delegate = self
        self.collectionViewForNews.dataSource = self
        
        self.collectionViewForNews.register(UINib(nibName: "HomeCVCellBig", bundle: .main), forCellWithReuseIdentifier: "HomeCVCellBig")
        
        self.collectionViewForNews.register(UINib(nibName: "HomeCVCell", bundle: .main), forCellWithReuseIdentifier: "HomeCVCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setData() {
        
        let param = self.newsData.getRequestForNewsList(vc: self)
        
        self.callTopHeadlines(params: param!) { (newsList) in
            
            self.arrNewsData.removeAll()
            self.arrNewsData = newsList
            //print(self.arrNewsData)
            
            self.collectionViewForNews.reloadData()
        }
    }
    
    @IBAction func tapCategoryBtn(_ sender: UIButton) {
        let vc = CategoriesVC(nibName: "CategoriesVC", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func tapSearchBtn(_ sender: UIButton) {
        
        let vc = SearchVC(nibName: "SearchVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            changeTabBar(hidden: true, animated: true)
        } else {
            changeTabBar(hidden: false, animated: true)
        }
    }
    
    func changeTabBar(hidden:Bool, animated: Bool) {
        
        let tabBar = self.tabBarController?.tabBar
        if tabBar!.isHidden == hidden{ return }
        let frame = tabBar?.frame
        let offset = (hidden ? (frame?.size.height)! : -(frame?.size.height)!)
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar?.isHidden = false
        if frame != nil {
            UIView.animate(withDuration: duration,
                           animations: {tabBar!.frame = self.view.frame.offsetBy(dx: 0, dy: offset)},
                           completion: {
                            print($0)
                            if $0 {tabBar?.isHidden = hidden}
            })
        }
    }
}

extension HomeVC: NewsBookmarkDelegate {
    
    func bookmarkBtn(_ sender: HomeCVCell) {
        
        //guard let tappedIndexPath = self.collectionViewForEverything.indexPath(for: sender) else { return }

        //let context = DatabaseController.persistentContainer.viewContext
        
        //self.arrBookmarkNews.insert(self.arrNewsData[tappedIndexPath.item], at: 0)
        //print(self.arrBookmarkNews)
        // Save the data into CoreData...
        //DatabaseController.saveContext()
    }
}

extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrNewsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCellBig", for: indexPath) as? HomeCVCellBig else {
                print("------- Cell cannot be created")
                return UICollectionViewCell()
            }
            
            cell.refreshData(news: self.arrNewsData[0])
            
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as? HomeCVCell else {
                print("------- Cell cannot be created")
                return UICollectionViewCell()
            }
            
            cell.refreshData(news: self.arrNewsData[indexPath.item])
            
            return cell
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = NewsDetailVC(nibName: "NewsDetailVC", bundle: nil)
        
        vc.newsTitle = arrNewsData[indexPath.item].title
        vc.newsPublishedDate = arrNewsData[indexPath.item].publishedAt
        vc.newsDescription = arrNewsData[indexPath.item].description
        vc.newsImage = arrNewsData[indexPath.item].urlToImage
        vc.newsReadMoreUrl = arrNewsData[indexPath.item].url
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 200.0)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 90.0)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        CellAnimator.animate(cell, withDuration: 0.5, animation: .Tilt)
    }
}
