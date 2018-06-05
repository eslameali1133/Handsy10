//
//  ProjectsContinueTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/14/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ProjectsContinueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var officeNameLabel: UILabel!
    @IBOutlet weak var ProjectBildTypeName: UILabel!
    @IBOutlet weak var StagesDetailsName: UILabel!
    @IBOutlet weak var CreateDate: UILabel!
    
    @IBOutlet weak var EngName: UILabel!
    @IBOutlet weak var companyAddress: UILabel!
    @IBOutlet weak var Details: UILabel!
    @IBOutlet weak var Status: UIImageView!
    @IBOutlet weak var nameOfStatus: UILabel!
    @IBOutlet weak var CompanyLogoImage: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.CompanyLogoImage.layer.cornerRadius = 7.0
                self.CompanyLogoImage.layer.masksToBounds = true
            }
        }
    }
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
    
    @IBOutlet weak var BtnOutlet: UIStackView!
    
    @IBOutlet weak var PDF: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.PDF.layer.cornerRadius = 4.0
            }
        }
    }
    
    @IBOutlet weak var designDetials: UIButton!{
        didSet {
            designDetials.layer.borderWidth = 1.0
            designDetials.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            designDetials.layer.cornerRadius = 4.0
        }
    }

    @IBOutlet weak var DownPdf: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.DownPdf.circleView(UIColor.clear, borderWidth: 1.0)
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
