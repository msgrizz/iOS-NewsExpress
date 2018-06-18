//
//  CategoriesCVCell.swift
//  NewsExpress
//
//  Created by Macbook on 10/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class CategoriesCVCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var imgCategories: UIImageView!
    
    @IBOutlet weak var viewLblBack: UIView!
    
    @IBOutlet weak var lblCategoriesName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.cardView.layer.cornerRadius = 5.0
    }
}
