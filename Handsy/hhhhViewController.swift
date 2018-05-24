//
//  hhhhViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/29/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class hhhhViewController: UIViewController {

    var width: CGFloat = 0
    var height: CGFloat = 0
    var status_nav_height: CGFloat = 0
    var project = NSDictionary()
    var photos = [NSMutableArray(), NSMutableArray()]
    var request = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tabBar() {
        /*var tabView1 = UIView(frame: CGRectMake(0, status_nav_height + 1.0 / 30.0 * height + 1.0 / 18.0 * height, width, height - (status_nav_height + 1.0 / 30.0 * height + 1.0 / 18.0 * height)))
         tabView1.tag = 400
         view.addSubview(tabView1)
         
         var tabView2 = UIView(frame: CGRectMake(0, status_nav_height, width, height - status_nav_height))
         tabView2.tag = 300
         tabView2.hidden = true
         view.addSubview(tabView2)
         
         var tabView3 = UIView(frame: CGRectMake(0, status_nav_height, width, height - status_nav_height))
         tabView3.tag = 200
         tabView3.hidden = true
         view.addSubview(tabView3)
         
         var tabView4 = UIView(frame: CGRectMake(0, status_nav_height + 1.0 / 30.0 * height + 1.0 / 18.0 * height, width, height - (status_nav_height + 1.0 / 30.0 * height + 1.0 / 18.0 * height)))
         tabView4.tag = 100
         tabView4.hidden = true
         view.addSubview(tabView4)*/
        
        /*var bar = UIView(frame: CGRectMake(1.0 / 20.0 * width, status_nav_height + 1.0 / 30.0 * height, 18.0 / 20.0 * width, 1.0 / 18.0 * height))
         bar.tag = 1000
         bar.layer.cornerRadius = 1.0 / 25.0 * width
         bar.backgroundColor = Constants.colors.primary
         view.addSubview(bar)*/
        
        var counting = 0
        
        let tabTitles = ["الحالة", "المهندس", "مرفقات", "البيانات"]
        
        
        for j in (0..<tabTitles.count){
            let bar = UIView(frame: CGRect(x: 1.0 / 20.0 * width, y: status_nav_height + 1.0 / 30.0 * height, width: 18.0 / 20.0 * width, height: 1.0 / 18.0 * height))
            bar.tag = j * 1000
            bar.layer.cornerRadius = 1.0 / 25.0 * width
            bar.backgroundColor = Constants.colors.primary
            
            for i in 0 ..< tabTitles.count {
                let tab = UIButton(frame: CGRect(x: CGFloat(i) * 1.0 / CGFloat(tabTitles.count) * bar.frame.width, y: 0, width: 1.0 / CGFloat(tabTitles.count) * bar.frame.width, height: bar.frame.height))
                tab.tag = counting+1
                tab.layer.cornerRadius = 1.0 / 25.0 * width
                tab.setTitle(tabTitles[i], for: UIControlState.normal)
                tab.setTitleColor(Constants.colors.hint, for: UIControlState.normal)
                tab.titleLabel?.font = UIFont(name: Constants.fontNames.mainFont, size: 1.0 / 25.0 * width)
                tab.addTarget(self, action: "tabBarAction:", for: UIControlEvents.touchUpInside)
                bar.addSubview(tab)
            }
            
            counting += 1
            
            let tab1 = view.viewWithTag(j) as! UIButton
            tab1.backgroundColor = Constants.colors.darkYellow
            tab1.setTitleColor(UIColor.white, for: UIControlState())
        }
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
 
