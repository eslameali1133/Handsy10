//
//  NewProjectMapAlertViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/21/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class NewProjectMapAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapDismiss(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
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
