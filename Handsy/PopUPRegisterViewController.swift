//
//  PopUPRegisterViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 2/22/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class PopUPRegisterViewController: UIViewController {

    @IBOutlet weak var endedBtn: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.endedBtn.circleView(UIColor.clear, borderWidth: 1.0)
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
    

    @IBAction func endedActionBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "WelcomeScreen", bundle: nil)
        let NavController = storyboard.instantiateViewController(withIdentifier: "NewWelcome") as! UINavigationController
        let FirstViewController = NavController.viewControllers.first as! NewWelcomeScreenViewController
        FirstViewController.logout = "logout"
        self.present(NavController, animated: false, completion: nil)
    }
    

}
