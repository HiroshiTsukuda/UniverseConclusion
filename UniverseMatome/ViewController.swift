//
//  ViewController.swift
//  UniverseMatome
//
//  Created by Tsukuda Hiroshi on 2020/04/07.
//  Copyright © 2020 Tsukuda Hiroshi. All rights reserved.
//

import UIKit
import SegementSlide
import GoogleMobileAds

class ViewController:SegementSlideViewController {
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bannerView.adUnitID = "ca-app-pub-1325656609004740/2370319060"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
        reloadData()
        scrollToSlide(at: 0, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.isNavigationBarHidden = true
       }
    
    override var headerView: UIView?{
        
        let headerView = UIImageView()
        
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleToFill
        headerView.image = UIImage(named: "スクリーンショット 2020-04-19 23.31.20")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerHeight: CGFloat
        
        if #available(ios 11.0, *){
            headerHeight = view.frame.size.height/5 + view.safeAreaInsets.top
            
        }else{
            headerHeight = view.frame.size.height/5 + topLayoutGuide.length
            
        }
        
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true

      //        falseだったら？？
              
        return headerView
        
    }
    
    override var titlesInSwitcher: [String]{
        
        return ["sorae","宙畑","astroarts","宇宙兄弟","ALMA","アストロピクス"]
        
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index{
            
        case 0:
        return Page1TableViewController()
        case 1:
        return Page2TableViewController()
        case 2:
        return Page3TableViewController()
        case 3:
        return Page4TableViewController()

        default : return Page1TableViewController()

        }
    }


}

