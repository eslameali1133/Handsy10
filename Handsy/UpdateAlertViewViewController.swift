//
//  UpdateAlertViewViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/31/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class UpdateAlertViewViewController: UIViewController {
    @IBOutlet weak var acceptUpdateOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss(_:)))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    @objc func tapDismiss(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func acceptUpdateAction(_ sender: UIButton) {
        launchingAppInStore()
    }
    
    func launchingAppInStore() {
        // App Store URL.
        let appStoreLink = "https://itunes.apple.com/us/app/handsy-هندسي/id1287033751?ls=1&mt=8"
        
        /* First create a URL, then check whether there is an installed app that can
         open it on the device. */
        if let url = URL(string: appStoreLink), UIApplication.shared.canOpenURL(url) {
            // Attempt to open the URL.
            UIApplication.shared.open(url, options: [:], completionHandler: {(success: Bool) in
                if success {
                    print("Launching \(url) was successful")
                }})
        } else{
            print("no update")
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
