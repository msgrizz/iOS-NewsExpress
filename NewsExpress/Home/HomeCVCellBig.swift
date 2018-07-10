//
//  HomeCVCellBig.swift
//  NewsExpress
//
//  Created by Macbook on 07/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class HomeCVCellBig: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imageNews: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var lblTitleNews: UILabel!
    
    @IBOutlet weak var lblTitlePublishedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func refreshData(news: News) {
        
        self.lblTitleNews.text = news.title
        
        let publishedAt = news.publishedAt
        self.lblTitlePublishedDate.text = self.dateFormatChange(yourdate: publishedAt, currentFormat: "yyyy-MM-dd'T'HH:mm:ssZ", requiredFormat: "dd MMM yyyy, hh:mm a")
        
        let imgURL = news.urlToImage
        self.imageNews.sd_setShowActivityIndicatorView(true)
        self.imageNews.sd_setIndicatorStyle(.gray)
        self.imageNews.sd_setImage(with: URL(string: imgURL), placeholderImage: #imageLiteral(resourceName: "placeholderImage"), options:.refreshCached)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainView.layer.cornerRadius = 3.0
        self.mainView.layer.masksToBounds = true
    }
    
}
