//
//  VisitsTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class VisitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var officeDirection: UIButton!{
        didSet {
            officeDirection.layer.borderWidth = 1.0
            officeDirection.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            officeDirection.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var callBtn: UIButton!{
        didSet {
            callBtn.layer.borderWidth = 1.0
            callBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            callBtn.layer.cornerRadius = 4.0
        }
    }
    
    
    @IBOutlet weak var messageChat: UIButton!{
        didSet {
            messageChat.layer.borderWidth = 1.0
            messageChat.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            messageChat.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var callEng: UIButton!{
        didSet {
            callEng.layer.borderWidth = 1.0
            callEng.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            callEng.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var visitDetials: UIButton!{
        didSet {
            visitDetials.layer.borderWidth = 1.0
            visitDetials.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            visitDetials.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var titleVisit: UILabel!
    @IBOutlet weak var descriptionProject: UILabel!
    @IBOutlet weak var companyAddress: UILabel!
    @IBOutlet weak var dateOfVisit: UILabel!
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusNameLabel: UILabel!
    @IBOutlet weak var companyLogoImage: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.companyLogoImage.layer.cornerRadius = 7.0
                self.companyLogoImage.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var officeNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
