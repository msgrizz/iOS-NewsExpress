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
    
    @IBOutlet weak var collectionViewHome: UICollectionView!
    
    //    var arrNewsData = [News]()
    var arrNewsData = [NewsUpdates]()
    
//    let navMenu = NavigationPanelVC.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewHome.delegate = self
        self.collectionViewHome.dataSource = self
        
        self.collectionViewHome.register(UINib(nibName: "HomeCVCell", bundle: .main), forCellWithReuseIdentifier: "HomeCVCell")
        
        self.collectionViewHome.register(UINib(nibName: "HomeCVCellBig", bundle: .main), forCellWithReuseIdentifier: "HomeCVCellBig")
        
        
        self.parseData()
        
//        self.navMenu.setParent(self, onCompletion: { (indexpath) in
        
//        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //self.navMenu.reloadData()
    }
    
    //    func setData() {
    //        self.callTopHeadlines(params: [:]) { (newsList) in
    //            self.arrNewsData.removeAll()
    //            self.arrNewsData = newsList
    //            print(self.arrNewsData)
    //        }
    //    }
    
    func parseData() {
        
        arrNewsData = []
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=71a951f960234350abbd37d823e4ee4d"
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                print(response.result.value ?? "")
                if let JSON = response.result.value as? [String: Any] {
                    
                    if let fetchedData = JSON["articles"] as? NSArray as! [[String : Any]]? {
                        //print(fetchedData)
                        
                        for each in fetchedData {
                            let topHeadline = each
                            
                            var author: String?
                            if (topHeadline["author"] as? String) != nil {
                                author = topHeadline["author"] as? String
                            } else {
                                author = "NA"
                            }
                            
                            var title: String?
                            if((topHeadline["title"] as? String) != nil) {
                                title = topHeadline["title"] as? String
                            } else {
                                title = "NA"
                            }
                            
                            var description: String?
                            if (topHeadline["description"] as? String) != nil {
                                description = topHeadline["description"] as? String
                            } else {
                                description = "NA"
                            }
                            
                            var url: String?
                            if((topHeadline["url"] as? String) != nil) {
                                url = topHeadline["url"] as? String
                            } else {
                                url = "NA"
                            }
                            
                            var publishedAt: String?
                            if((topHeadline["publishedAt"] as? String) != nil) {
                                publishedAt = topHeadline["publishedAt"] as? String
                            } else {
                                publishedAt = "NA"
                            }
                            
                            var urlToImage: String?
                            if((topHeadline["urlToImage"] as? String) != nil) {
                                urlToImage = topHeadline["urlToImage"] as? String
                            } else {
                                urlToImage = "NA"
                            }
                            
                            self.arrNewsData.append(NewsUpdates(author: author!, title: title!, description: description!, url: url!, urlToImage: urlToImage!, publishedAt: publishedAt!))
                        }
                        //print(self.arrNewsData)
                    }
                    //                    if(self.fetchedNews.count > 0){
                    //                        self.activityIndicatorView.stopAnimating()
                    //                    }
                    self.collectionViewHome.reloadData()
                }
        }
    }
    
    @IBAction func tapCategoryBtn(_ sender: UIButton) {
        //self.navMenu.toggleSlide()
        let vc = CategoriesVC(nibName: "CategoriesVC", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func tapSearchBtn(_ sender: UIButton) {
        showErrorAlert(title: "Sorry!", message: "Ayush didn't implement this feature yet.")
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            changeTabBar(hidden: true, animated: true)
        } else {
            changeTabBar(hidden: false, animated: true)
        }
    }
    
    func changeTabBar(hidden:Bool, animated: Bool){
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

extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrNewsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            guard let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCellBig", for: indexPath) as? HomeCVCellBig else {
                print("------- Big cell cannot be created")
                return UICollectionViewCell()
            }
            bigCell.lblTitleNews.text = self.arrNewsData[0].title
            
            let publishedAt = self.arrNewsData[0].publishedAt
            bigCell.lblTitlePublishedDate.text = self.dateFormatChange(yourdate: publishedAt!, currentFormat: "yyyy-MM-dd'T'HH:mm:ssZ", requiredFormat: "dd MMM yyyy, hh:mm a")
            
            let imgURL = self.arrNewsData[0].urlToImage
            bigCell.imageNews.sd_setShowActivityIndicatorView(true)
            bigCell.imageNews.sd_setIndicatorStyle(.gray)
            bigCell.imageNews.sd_setImage(with: URL(string: imgURL!), placeholderImage: #imageLiteral(resourceName: "default"), options:.refreshCached)
            
            return bigCell
        } else {
            guard let smallCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as? HomeCVCell else {
                print("------- Small cell cannot be created")
                return UICollectionViewCell()
            }
            
            smallCell.lblTitleNews.text = self.arrNewsData[indexPath.item].title
            
            let publishedAt = self.arrNewsData[indexPath.item].publishedAt
            
            smallCell.lblTitlePublishedDate.text = self.dateFormatChange(yourdate: publishedAt!, currentFormat: "yyyy-MM-dd'T'HH:mm:ssZ", requiredFormat: "dd MMM yyyy, hh:mm a")
            
            let imgURL = self.arrNewsData[indexPath.item].urlToImage?.trim()
            smallCell.imageNews.sd_setShowActivityIndicatorView(true)
            smallCell.imageNews.sd_setIndicatorStyle(.gray)
            smallCell.imageNews.sd_setImage(with: URL(string: imgURL!), placeholderImage: #imageLiteral(resourceName: "default"), options:.refreshCached)
            
            smallCell.imageNews.layer.cornerRadius = 3.0
            
            return smallCell
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
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width - 50.0)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 110.0)
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
