//
//  NewsDetailVC.swift
//  NewsExpress
//
//  Created by Macbook on 09/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class NewsDetailVC: UIViewController {
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var imgAudio: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblPublishedDate: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblNewsDescription: UILabel!
    
    @IBOutlet weak var btnReadMore: UIButton!
    
    var newsTitle: String?
    var newsPublishedDate: String?
    var newsImage: String?
    var newsDescription: String?
    var newsReadMoreUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.lblNewsTitle.text = self.newsTitle
        self.lblPublishedDate.text = self.dateFormatChange(yourdate: self.newsPublishedDate!, currentFormat: "yyyy-MM-dd'T'HH:mm:ssZ", requiredFormat: "dd MMM yyyy, hh:mm a")
        self.lblNewsDescription.text = self.newsDescription
        
        self.imgNews.sd_setShowActivityIndicatorView(true)
        self.imgNews.sd_setIndicatorStyle(.gray)
        self.imgNews.sd_setImage(with: URL(string: newsImage!), placeholderImage: #imageLiteral(resourceName: "default"), options:.refreshCached)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.imgNews.layer.cornerRadius = 5.0
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapShareBtn(_ sender: UIButton) {
        let newsUrl = newsReadMoreUrl
        let activityVC = UIActivityViewController(activityItems: [newsUrl!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func tapAudioBtn(_ sender: UIButton) {
        
        self.textToSpeach(text: self.lblNewsTitle.text!, language: "en-US", rate: 0.44, pitchMultiplier: 1.0, volume: 1.0)
        
        //self.textToSpeach(text: self.lblNewsDescription.text!, language: "en-US", rate: 0.5, pitchMultiplier: 1.0, volume: 1.0)
    }
    
    @IBAction func tapReadMoreBtn(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: self.newsReadMoreUrl!)!)
    }
}
