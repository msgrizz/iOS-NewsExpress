//
//  QuoteVC.swift
//  NewsExpress
//
//  Created by Macbook on 10/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class QuoteVC: UIViewController {
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var collectionViewForQuotes: UICollectionView!
    
    let personImage = [#imageLiteral(resourceName: "stevejobs"), #imageLiteral(resourceName: "drapj"), #imageLiteral(resourceName: "einstene"), #imageLiteral(resourceName: "stevejobs"), #imageLiteral(resourceName: "drapj"), #imageLiteral(resourceName: "einstene"), #imageLiteral(resourceName: "stevejobs"), #imageLiteral(resourceName: "drapj")]
    let personName = ["- Steve Jobs", "- Dr. APJ Abdul Kalam", "Einstene", "- Steve Jobs", "- Dr. APJ Abdul Kalam", "- Einstene", "- Steve Jobs", "- Dr. APJ Abdul Kalam"]
    let quotes = ["“Don’t let the noise of others’ opinions drown out your own inner voice.”", "“You have to dream before your dreams can come true.”", "“Few are those who see with their own eyes and feel with their own hearts.”", "“Creativity is just connecting things.”", "“We should not give up and we should not allow the problem to defeat us.”", "“Great spirits have always encountered violent opposition from mediocre minds.”", "“Your time is limited, so don’t waste it living someone else’s life.”", "“Man needs his difficulties because they are necessary to enjoy success.”"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnBack.isHidden = true
        self.imgBack.isHidden = true
        
        self.collectionViewForQuotes.delegate = self
        self.collectionViewForQuotes.dataSource = self
        
        self.collectionViewForQuotes.register(UINib(nibName: "QuoteCVCell", bundle: .main), forCellWithReuseIdentifier: "QuoteCVCell")
        
        self.collectionViewForQuotes.reloadData()
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

extension QuoteVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.personImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuoteCVCell", for: indexPath) as? QuoteCVCell else {
            print("------- Cell cannot be created")
            return UICollectionViewCell()
        }
        cell.imgPerson.image = self.personImage[indexPath.item]
        cell.lblPersonName.text = self.personName[indexPath.item]
        cell.lblQuote.text = self.quotes[indexPath.item]
        return cell
    }
}

extension QuoteVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let vc = NewsDetailVC(nibName: "NewsDetailVC", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 90.0)
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
