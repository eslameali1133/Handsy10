//
//  ContactUSViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 4/4/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ContactUSViewController: UIViewController {
    @IBOutlet weak var MailLabel: UIButton!
    @IBOutlet weak var webSiteLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func assignbackground(){
        let imageView = UIImageView(image: #imageLiteral(resourceName: "splash"))
        imageView.contentMode = .scaleAspectFill
        self.view.insertSubview(imageView, at: 0)
        self.view.sendSubview(toBack: imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.layoutIfNeeded()
    }

    @IBAction func firstMobileBtn(_ sender: UIButton) {
        var mobileText: String = "+966504414257"
        if mobileText.count == 10 {
            if mobileText.first! == "0" {
                if mobileText[mobileText.index(mobileText.startIndex, offsetBy: 1)] == "5" {
                    mobileText.remove(at: mobileText.startIndex)
                    mobileText.insert("6", at: mobileText.startIndex)
                    mobileText.insert("6", at: mobileText.startIndex)
                    mobileText.insert("9", at: mobileText.startIndex)
                    callNumber(phoneNumber: mobileText)
                }else {
                    callNumber(phoneNumber: mobileText)
                }
            }else {
                callNumber(phoneNumber: mobileText)
            }
        } else {
            callNumber(phoneNumber: mobileText)
        }
    }
    
    @IBAction func secondMobileBtn(_ sender: UIButton) {
        var mobileText: String = "+966591111629"
        if mobileText.count == 10 {
            if mobileText.first! == "0" {
                if mobileText[mobileText.index(mobileText.startIndex, offsetBy: 1)] == "5" {
                    mobileText.remove(at: mobileText.startIndex)
                    mobileText.insert("6", at: mobileText.startIndex)
                    mobileText.insert("6", at: mobileText.startIndex)
                    mobileText.insert("9", at: mobileText.startIndex)
                    callNumber(phoneNumber: mobileText)
                }else {
                    callNumber(phoneNumber: mobileText)
                }
            }else {
                callNumber(phoneNumber: mobileText)
            }
        } else {
            callNumber(phoneNumber: mobileText)
        }
    }
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func MailBtn(_ sender: UIButton) {
        let email: String = (MailLabel.titleLabel?.text!)!
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openWebsite(_ sender: Any) {
        let url = URL(string: ("https://"+(webSiteLabel.titleLabel?.text!)!))
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                print("Open url : \(success)")
            })
        }
    }
    
    
}
