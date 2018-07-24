//
//  ProjectsContinueTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/14/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ProjectsContinueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var officeNameLabel: UIButton!
    
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var StagesDetailsName: UILabel!
    @IBOutlet weak var CreateDate: UILabel!
    
    @IBOutlet weak var companyAddress: UILabel!
    @IBOutlet weak var Details: UILabel!
    @IBOutlet weak var Status: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.Status.roundCorners(.bottomRight, radius: 10.0)
            }
        }
    }
    @IBOutlet weak var nameOfStatus: UILabel!
    @IBOutlet weak var CompanyLogoImage: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.CompanyLogoImage.layer.cornerRadius = 7.0
                self.CompanyLogoImage.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var projectDetials: UIButton!{
        didSet {
            projectDetials.layer.borderWidth = 1.0
            projectDetials.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            projectDetials.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var companyMobile: UIButton!
    @IBOutlet weak var PDF: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.PDF.layer.cornerRadius = 4.0
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.roundCorners([.bottomLeft,.bottomRight,.topRight], radius: 10)
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
