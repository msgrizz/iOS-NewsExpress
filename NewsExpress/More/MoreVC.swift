//
//  MoreVC.swift
//  NewsExpress
//
//  Created by Macbook on 10/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
import MessageUI

class MoreVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblAppName: UILabel!
    @IBOutlet weak var lblPoweredBy: UILabel!
    
    @IBOutlet weak var btnNightMode: UIButton!
    @IBOutlet weak var btnAboutTheApp: UIButton!
    @IBOutlet weak var btnOpenSource: UIButton!
    @IBOutlet weak var btnPoweredBy: UIButton!
    @IBOutlet weak var btnContactUs: UIButton!
    @IBOutlet weak var switchNightMode: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnBack.isHidden = true
        self.imgBack.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.imgLogo.layer.cornerRadius = 8.0
        self.imgLogo.layer.masksToBounds = true
    }
    
    @IBAction func tapNightModeSwitch(_ sender: UISwitch) {
        
        
    }
    
    @IBAction func tapAboutTheAppBtn(_ sender: UIButton) {
        
        let vc = AboutTheAppVC(nibName: "AboutTheAppVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapOpenSourceBtn(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: "https://github.com/guptaayush374/iOS-NewsExpress")!)
    }
    
    @IBAction func tapPoweredByBtn(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: "https://newsapi.org")!)
    }
    
    @IBAction func tapContactUsBtn(_ sender: UIButton) {
        
        if !MFMailComposeViewController.canSendMail() {
            self.showErrorAlert(title: "Alert!", message: "Mail services is not available.")
            return
        } else {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            composeVC.setToRecipients(["guptaayush374@gmail.com"])
            composeVC.setSubject("")
            composeVC.setMessageBody("", isHTML: false)
            
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}
