//
//  BranchTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 11/29/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit


class BranchTableViewCell: UITableViewCell, GMSMapViewDelegate {

    @IBOutlet weak var BranchName: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var mobile: UIButton!
    @IBOutlet weak var fax: UIButton!
    @IBOutlet weak var mail: UIButton!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var directionsOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.directionsOut.layer.cornerRadius = 7.0
                self.directionsOut.layer.masksToBounds = true
                self.directionsOut.backgroundColor = UIColor(red: 17.0/255.0, green: 119.0/255.0, blue: 151.0/255.0, alpha: 0.5)
            }
        }
    }
    
    @IBOutlet weak var mapType: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.mapType.layer.cornerRadius = 7.0
                self.mapType.layer.masksToBounds = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mapView.delegate = self
        mapType.backgroundColor = UIColor(red: 17.0/255.0, green: 119.0/255.0, blue: 151.0/255.0, alpha: 0.5)
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
        }else {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
        }
    }
    
    @IBAction func mapTypeAction(_ sender: UIButton) {
        if mapView.mapType == .satellite {
            mapType.setImage(#imageLiteral(resourceName: "google-drive-image copy copy"), for: .normal)
            mapView.mapType = .terrain
        }else {
            mapType.setImage(#imageLiteral(resourceName: "landscape-with-mountains"), for: .normal)
            mapView.mapType = .satellite
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func MobileBtn(_ sender: UIButton) {
        var mobileText: String = (mobile.titleLabel?.text!)!
        if mobileText.characters.count == 10 {
            if mobileText.characters.first! == "0" {
                if mobileText.characters[mobileText.index(mobileText.characters.startIndex, offsetBy: 1)] == "5" {
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
    
    @IBAction func FaxBtn(_ sender: UIButton) {
        var faxText: String = (fax.titleLabel?.text!)!
        if faxText.characters.count == 10 {
            if faxText.characters.first! == "0" {
                if faxText.characters[faxText.index(faxText.characters.startIndex, offsetBy: 1)] == "5" {
                    faxText.remove(at: faxText.startIndex)
                    faxText.insert("6", at: faxText.startIndex)
                    faxText.insert("6", at: faxText.startIndex)
                    faxText.insert("9", at: faxText.startIndex)
                    callNumber(phoneNumber: faxText)
                }else {
                    callNumber(phoneNumber: faxText)
                }
            }else {
                callNumber(phoneNumber: faxText)
            }
        } else {
            callNumber(phoneNumber: faxText)
        }
    }
    
    @IBAction func MailBtn(_ sender: UIButton) {
        let email: String = (mail.titleLabel?.text!)!
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func FBBtn(_ sender: UIButton) {
        let facebookText: String = (facebook.titleLabel?.text!)!
        let url = URL(string: facebookText)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

}
