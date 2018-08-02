//
//  AlertDoneViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/16/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class AlertDoneViewController: UIViewController {

    @IBOutlet weak var popUpBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.popUpBtnOut.circleView(UIColor.clear, borderWidth: 1.0)
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
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        //        let sub = self.storyboard?.instantiateViewController(withIdentifier: "main") as! MyTabBarController
        //        self.present(sub, animated: true ,completion: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func end(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain")
        let topController = UIApplication.topViewController()
        topController?.show(sub, sender: true)
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
