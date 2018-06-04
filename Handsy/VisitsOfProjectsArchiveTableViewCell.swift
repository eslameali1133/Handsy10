//
//  VisitsOfProjectsArchiveTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/24/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class VisitsOfProjectsArchiveTableViewCell: UITableViewCell {
    @IBOutlet weak var companyCallBtn: UIButton! {
        didSet {
            companyCallBtn.layer.borderWidth = 1.0
            companyCallBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            companyCallBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var visitsDetialsBtn: UIButton! {
        didSet {
            visitsDetialsBtn.layer.borderWidth = 1.0
            visitsDetialsBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            visitsDetialsBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var visitsMessageBtn: UIButton! {
        didSet {
            visitsMessageBtn.layer.borderWidth = 1.0
            visitsMessageBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            visitsMessageBtn.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var titleVisit: UILabel!
    @IBOutlet weak var dateOfVisit: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusNameLabel: UILabel!
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var EmpNameLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
