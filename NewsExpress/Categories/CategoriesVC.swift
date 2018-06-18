//
//  CategoriesVC.swift
//  NewsExpress
//
//  Created by Macbook on 10/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var lblNavBarTitle: UILabel!
    @IBOutlet weak var imgCancel: UIImageView!
    
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    
    let arrSection = ["GENERAL", "ENTERTAINMENT", "SPORTS", "SCIENCE", "TECHNOLOGY", "GAMING"]
    
    let arrGeneralTitle = ["Google News", "BBC", "The Hindu", "TOI", "The Hindu"]
    let arrGeneralImage = [#imageLiteral(resourceName: "google-news"), #imageLiteral(resourceName: "bbc-news"), #imageLiteral(resourceName: "theHindu-news"), #imageLiteral(resourceName: "toi-news"), #imageLiteral(resourceName: "theHindu-news")]
    
    let arrEntertainmentTitle = ["Buzzfeed", "Mashable", "MTV News"]
    let arrEntertainmentImage = [#imageLiteral(resourceName: "google-news"), #imageLiteral(resourceName: "bbc-news"), #imageLiteral(resourceName: "theHindu-news")]
    
    let arrSportsTitle = ["BBC Sports", "ESPN Cric Info", "TalkSports"]
    let arrSportsImage = [#imageLiteral(resourceName: "google-news"), #imageLiteral(resourceName: "bbc-news"), #imageLiteral(resourceName: "theHindu-news")]
    
    let arrScienceTitle = ["Medical News Today", "National Geographic"]
    let arrScienceImage = [#imageLiteral(resourceName: "google-news"), #imageLiteral(resourceName: "bbc-news")]
    
    let arrTechnologyTitle = ["Crypto Coins News", "Engadget", "The Next Web", "The Verge", "TechCrunch", "TechReader"]
    let arrTechnologyImage = [#imageLiteral(resourceName: "google-news"), #imageLiteral(resourceName: "bbc-news"), #imageLiteral(resourceName: "theHindu-news"), #imageLiteral(resourceName: "toi-news"), #imageLiteral(resourceName: "theHindu-news"), #imageLiteral(resourceName: "google-news")]
    
    let arrGamingTitle = ["IGN", "Polygon"]
    let arrGamingImage = [#imageLiteral(resourceName: "google-news"), #imageLiteral(resourceName: "bbc-news")]
    
    var arrCombined: NSMutableArray! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrCombined = NSMutableArray(array: [arrGeneralImage, arrEntertainmentImage, arrSportsImage, arrScienceImage, arrTechnologyImage, arrGamingImage])
        
        self.collectionViewCategories.delegate = self
        self.collectionViewCategories.dataSource = self
        
        self.collectionViewCategories.register(UINib(nibName: "CategoriesCVCell", bundle: .main), forCellWithReuseIdentifier: "CategoriesCVCell")
        
        self.collectionViewCategories.register(UINib(nibName: "CategoriesSectionCRV", bundle: .main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CategoriesSectionCRV")
    }
    
    @IBAction func tapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CategoriesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusable: UICollectionReusableView? = nil
        if(kind == UICollectionElementKindSectionHeader) {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CategoriesSectionCRV", for: indexPath) as! CategoriesSectionCRV
            view.lblSectionTitle.text = arrSection[indexPath.section]
            reusable = view
        }
        return reusable!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.arrSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.arrCombined.object(at: section) as! NSArray).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCVCell", for: indexPath) as? CategoriesCVCell else {
            print("-------  Cell cannot be created")
            return UICollectionViewCell()
        }
        
        if indexPath.section == 0 {
            cell.lblCategoriesName.text = self.arrGeneralTitle[indexPath.item]
            cell.imgCategories.image = self.arrGeneralImage[indexPath.item]
        } else if indexPath.section == 1 {
            cell.lblCategoriesName.text = self.arrEntertainmentTitle[indexPath.item]
            cell.imgCategories.image = self.arrEntertainmentImage[indexPath.item]
        } else if indexPath.section == 2 {
            cell.lblCategoriesName.text = self.arrSportsTitle[indexPath.item]
            cell.imgCategories.image = self.arrSportsImage[indexPath.item]
        } else if indexPath.section == 3 {
            cell.lblCategoriesName.text = self.arrScienceTitle[indexPath.item]
            cell.imgCategories.image = self.arrScienceImage[indexPath.item]
        } else if indexPath.section == 4 {
            cell.lblCategoriesName.text = self.arrTechnologyTitle[indexPath.item]
            cell.imgCategories.image = self.arrTechnologyImage[indexPath.item]
        } else if indexPath.section == 5 {
            cell.lblCategoriesName.text = self.arrGeneralTitle[indexPath.item]
            cell.imgCategories.image = self.arrGamingImage[indexPath.item]
        }
        
        return cell
    }
}

extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/3) - 2, height: UIScreen.main.bounds.width/3)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        CellAnimator.animate(cell, withDuration: 0.5, animation: .Tilt)
    }
}
