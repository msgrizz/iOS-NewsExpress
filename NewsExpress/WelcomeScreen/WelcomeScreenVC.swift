//
//  WelcomeScreenVC.swift
//  NewsExpress
//
//  Created by Macbook on 03/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class WelcomeScreenVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    var arrayOfChildVC = [UIViewController]()
    
    var pageCount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        
        let vc1 = WelcomeScreenFirstVC(nibName: "WelcomeScreenFirstVC", bundle: nil)
        let vc2 = WelcomeScreenSecondVC(nibName: "WelcomeScreenSecondVC", bundle: nil)
        let vc3 = WelcomeScreenThirdVC(nibName: "WelcomeScreenThirdVC", bundle: nil)
        
        arrayOfChildVC = [vc1, vc2, vc3]
        
        self.pageControl.numberOfPages = self.arrayOfChildVC.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.skipBtn.buttonShadow()
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        //let height = bounds.size.height
        
        let widthScrollView = scrollView.frame.size.width
        let heightScrollView = scrollView.frame.size.height
        
        scrollView!.contentSize = CGSize(width: 3 * width, height: heightScrollView)
        var idx: Int = 0
        for childVC in arrayOfChildVC {
            addChildViewController(childVC)
            let originX: CGFloat = CGFloat(idx) * width
            childVC.view.frame = CGRect(x: originX, y: 0, width: widthScrollView, height: heightScrollView)
            scrollView!.addSubview(childVC.view)
            childVC.didMove(toParentViewController: self)
            idx += 1
        }
    }
    
    @IBAction func tapSkipBtn(_ sender: UIButton) {
        
    }
}

extension WelcomeScreenVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}
