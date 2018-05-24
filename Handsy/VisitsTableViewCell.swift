//
//  VisitsTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class VisitsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleVisit: UILabel!
    @IBOutlet weak var descriptionProject: UILabel!
    @IBOutlet weak var dateOfVisit: UILabel!
    @IBOutlet weak var empName: UIButton!
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
