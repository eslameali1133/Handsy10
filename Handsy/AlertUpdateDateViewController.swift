//
//  AlertUpdateDateViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class AlertUpdateDateViewController: UIViewController {
    
    @IBOutlet weak var endBtnOut: UIButton!
        {
        didSet {
            DispatchQueue.main.async {
                self.endBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func end(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain")
        let topController = UIApplication.topViewController()
        topController?.show(sub, sender: true)
    }
    
}
