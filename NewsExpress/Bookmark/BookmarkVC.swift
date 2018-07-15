//
//  BookmarkVC.swift
//  NewsExpress
//
//  Created by Macbook on 10/07/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class BookmarkVC: UIViewController {
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var collectionViewForEverything: UICollectionView!
    
    var arrBookmarkNews = [BookmarkNewsList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnBack.isHidden = true
        self.imgBack.isHidden = true
        
        self.collectionViewForEverything.delegate = self
        self.collectionViewForEverything.dataSource = self
        
        self.collectionViewForEverything.register(UINib(nibName: "HomeCVCell", bundle: .main), forCellWithReuseIdentifier: "HomeCVCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension BookmarkVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrBookmarkNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let smallCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as? HomeCVCell else {
            print("------- Small cell cannot be created")
            return UICollectionViewCell()
        }
        
        //smallCell.refreshData(news: self.arrBookmarkNews[indexPath.item])
        
        return smallCell
    }
}

extension BookmarkVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = NewsDetailVC(nibName: "NewsDetailVC", bundle: nil)
        vc.newsTitle = self.arrBookmarkNews[indexPath.item].title
        vc.newsPublishedDate = self.arrBookmarkNews[indexPath.item].publishedAt
        vc.newsDescription = self.arrBookmarkNews[indexPath.item].newsDescription
        vc.newsImage = self.arrBookmarkNews[indexPath.item].urlToImage
        vc.newsReadMoreUrl = self.arrBookmarkNews[indexPath.item].url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 90.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        CellAnimator.animate(cell, withDuration: 0.5, animation: .Tilt)
    }
}
