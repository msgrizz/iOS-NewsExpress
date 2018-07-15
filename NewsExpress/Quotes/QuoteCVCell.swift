//
//  QuoteCVCell.swift
//  NewsExpress
//
//  Created by Macbook on 15/07/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class QuoteCVCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewImgBack: UIView!
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblQuote: UILabel!
    @IBOutlet weak var lblPersonName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imgPerson.layer.cornerRadius = self.imgPerson.frame.height/2
        self.viewImgBack.layer.cornerRadius = self.viewImgBack.frame.height/2
        self.viewImgBack.layer.borderColor = UIColor(hex: "033d6b").cgColor
        self.viewImgBack.layer.borderWidth = 1.5
    }
}
