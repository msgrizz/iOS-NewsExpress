//
//  WelcomeScreenFirstVC.swift
//  NewsExpress
//
//  Created by Macbook on 04/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class WelcomeScreenFirstVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgWelcome: UIImageView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTitle.alpha = 0
        self.imgWelcome.alpha = 0
        self.lblDescription.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        UIView.animate(withDuration: 2.0) {
            self.lblTitle.alpha = 1
            self.imgWelcome.alpha = 1
            self.lblDescription.alpha = 1
        }
    }
}
