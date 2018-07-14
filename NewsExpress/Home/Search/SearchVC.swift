//
//  SearchVC.swift
//  NewsExpress
//
//  Created by Macbook on 25/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewNav: UIView!
    
    @IBOutlet weak var txtFieldSearch: UITextField!
    
    @IBOutlet weak var collectionViewSearch: UICollectionView!
    
    var arrNewsData = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewSearch.delegate = self
        self.collectionViewSearch.dataSource = self
        
        self.collectionViewSearch.register(UINib(nibName: "HomeCVCell", bundle: .main), forCellWithReuseIdentifier: "HomeCVCell")
        
        self.txtFieldSearch.delegate = self
        self.txtFieldSearch.becomeFirstResponder()
        
        self.addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard() {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SearchVC.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.txtFieldSearch.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.txtFieldSearch.resignFirstResponder()
        
        if self.txtFieldSearch.text?.count != 0 {
            self.setData(query: (self.txtFieldSearch.text?.trim())!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    func setData(query: String) {
        
        let param = [
            "q": query,
            "apiKey": GlobalConstants.apiKey
        ]
        self.callNewsSearch(params: param) { (newsList) in
            self.arrNewsData.removeAll()
            self.arrNewsData = newsList
            //print(self.arrNewsData)
            self.collectionViewSearch.reloadData()
        }
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapDoneBtn(_ sender: UIButton) {
        if self.txtFieldSearch.text?.count != 0 {
            self.setData(query: (self.txtFieldSearch.text?.trim())!)
        }
    }
}

extension SearchVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrNewsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let smallCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as? HomeCVCell else {
            print("------- Small cell cannot be created")
            return UICollectionViewCell()
        }
        
        smallCell.lblTitleNews.text = self.arrNewsData[indexPath.item].title
        
        let publishedAt = self.arrNewsData[indexPath.item].publishedAt
        
        smallCell.lblTitlePublishedDate.text = self.dateFormatChange(yourdate: publishedAt, currentFormat: "yyyy-MM-dd'T'HH:mm:ssZ", requiredFormat: "dd MMM yyyy, hh:mm a")
        
        let imgURL = self.arrNewsData[indexPath.item].urlToImage.trim()
        smallCell.imageNews.sd_setShowActivityIndicatorView(true)
        smallCell.imageNews.sd_setIndicatorStyle(.gray)
        smallCell.imageNews.sd_setImage(with: URL(string: imgURL), placeholderImage: #imageLiteral(resourceName: "placeholderImage"), options:.refreshCached)
        
        smallCell.imageNews.layer.cornerRadius = 3.0
        
        return smallCell
    }
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
