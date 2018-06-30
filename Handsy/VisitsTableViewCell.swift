//
//  VisitsTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class VisitsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var visitDetials: UIButton!{
        didSet {
            visitDetials.layer.borderWidth = 1.0
            visitDetials.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            visitDetials.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var titleVisit: UILabel!
    @IBOutlet weak var companyAddress: UILabel!
    @IBOutlet weak var dateOfVisit: UILabel!
    @IBOutlet weak var statusV: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.statusV.roundCorners(.bottomRight, radius: 10.0)
            }
        }
    }
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
    @IBOutlet weak var officeNameLabel: UILabel!
    
    
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
