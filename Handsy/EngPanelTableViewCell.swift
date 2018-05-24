//
//  EngPanelTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/23/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class EngPanelTableViewCell: UITableViewCell {

    @IBOutlet weak var officePlace: UILabel!
    @IBOutlet weak var nameOfEmploy: UILabel!
    @IBOutlet weak var mobileEmploy: UILabel!
    @IBOutlet weak var empNameOfJob: UILabel!
    @IBOutlet weak var EngNotes: UITextView!
    @IBOutlet weak var EngNotesStack: UIStackView!
    @IBOutlet weak var EngNotesLabel: UILabel!
    
    @IBOutlet weak var call: UIButton!
    
    @IBAction func CallMe(_ sender: UIButton) {
        var mobile = mobileEmploy.text!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
