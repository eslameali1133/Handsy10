//
//  RequestTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/2/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    @IBOutlet weak var EmpImage: AMCircleImageView!
    @IBOutlet weak var AddressProject: UILabel!
    @IBOutlet weak var TyoeProject: UILabel!
    @IBOutlet weak var EmpName: UILabel!
    @IBOutlet weak var Mobile: UIButton!
    @IBOutlet weak var mobileImage: UIImageView!
    @IBOutlet weak var StatusImage: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func CallMe(_ sender: UIButton) {
        var mobile: String = (Mobile.titleLabel?.text!)!
        if mobile.count == 10 {
            if mobile.first! == "0" {
                if mobile[mobile.index(mobile.startIndex, offsetBy: 1)] == "5" {
                    mobile.remove(at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("6", at: mobile.startIndex)
                    mobile.insert("9", at: mobile.startIndex)
                    callNumber(phoneNumber: mobile)
                } else {
                    callNumber(phoneNumber: mobile)
                }
            } else {
                callNumber(phoneNumber: mobile)
            }
        } else {
            callNumber(phoneNumber: mobile)
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
    
}
