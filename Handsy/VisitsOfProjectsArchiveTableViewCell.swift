//
//  VisitsOfProjectsArchiveTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/24/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class VisitsOfProjectsArchiveTableViewCell: UITableViewCell {

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
