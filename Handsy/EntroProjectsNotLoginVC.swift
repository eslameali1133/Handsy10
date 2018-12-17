//
//  EntroProjectsNotLoginVC.swift
//  Handsy
//
//  Created by apple on 11/28/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class EntroProjectsNotLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "مشاريعي"

        // Do any additional setup after loading the view.
    }
    
  

    @IBOutlet weak var GotoLogin: UIButton!{
        didSet{
            GotoLogin.layer.cornerRadius = 8
        }
    }
    
    @IBAction func Gotologin(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let storyboard = UIStoryboard(name: "NewLogin", bundle: nil)
        let sub = storyboard.instantiateViewController(withIdentifier: "NewLoginViewController")
        self.navigationController?.pushViewController(sub, animated: true)
    }
    

}
