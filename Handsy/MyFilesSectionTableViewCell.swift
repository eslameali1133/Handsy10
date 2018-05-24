//
//  MyFilesSectionTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/30/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MyFilesSectionTableViewCell: UITableViewCell {
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var expandingImage: UIImageView!
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
