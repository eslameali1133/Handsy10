//
//  aboutHangsyViewController.swift
//  Handsy
//
//  Created by apple on 10/18/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class aboutHangsyViewController: UIViewController {
   
    
     @IBOutlet weak var Segm: AWSegmentAbout!
     @IBOutlet weak var SegmNotlog: AWSegmentAboutNOtLogin!
    
    @IBOutlet weak var CallMeView: UIView!
    @IBOutlet weak var CreateOfficeView: UIView!
    @IBOutlet weak var AbotView: UIView!
    
    @IBAction func Segment(_ sender: AWSegmentMoney) {
        switch Segm.selectedIndex
        {
        case 0:
           AbotView.isHidden = false
            CreateOfficeView.isHidden = true
             CallMeView.isHidden = true
        case 1:
            AbotView.isHidden = true
            CreateOfficeView.isHidden = true
            CallMeView.isHidden = false
        case 2:
            AbotView.isHidden = true
            CreateOfficeView.isHidden = false
            CallMeView.isHidden = true
        default:
            break;
        }
        
    }
   
    @IBAction func segnotlogin(_ sender: Any) {
          
        switch SegmNotlog.selectedIndex
        {
        case 0:
            AbotView.isHidden = true
            
            CreateOfficeView.isHidden = true
            CallMeView.isHidden = false
            
        case 1:
           
         CreateOfficeView.isHidden = false
             AbotView.isHidden = true
        case 2:
            AbotView.isHidden = true
            
            CallMeView.isHidden = true
        default:
            break;
        }
        
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        CreateOfficeView.isHidden = false
        CallMeView.isHidden = true
         AbotView.isHidden = true
 let CustmoerId = UserDefaults.standard.string(forKey: "CustmoerId")
        if CustmoerId == nil
        {
            Segm.isHidden = true
            SegmNotlog.isHidden = false
        }
        else
        {
            Segm.isHidden = false
            SegmNotlog.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

   

}
