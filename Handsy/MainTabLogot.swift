//
//  MainTabLogot.swift
//  Handsy
//
//  Created by apple on 10/25/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MainTabLogot: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tabBar.items?[3].selectedImage = UIImage(named:"group_627_1_1")?.withRenderingMode(.alwaysOriginal)
//        self.tabBar.items?[3].image = UIImage(named: "group_627_1")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[0].title = "البحث"
        
        tabBar.items?[1].titlePositionAdjustment = UIOffsetMake(0, -3)
        tabBar.items?[2].titlePositionAdjustment = UIOffsetMake(0, -3)
        tabBar.items?[3].titlePositionAdjustment = UIOffsetMake(0, -3)
        tabBar.items?[0].titlePositionAdjustment = UIOffsetMake(0, -3)
        
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
