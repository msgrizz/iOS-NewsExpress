//
//  AboutTheAppVC.swift
//  NewsExpress
//
//  Created by Macbook on 15/07/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class AboutTheAppVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tapBackBtn(_ sender: UIButton) {
   
        self.navigationController?.popViewController(animated: true)
    }
    
}
