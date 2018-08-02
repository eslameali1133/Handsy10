//
//  ExparTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 11/9/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var ExperienceTit: UILabel!
    @IBOutlet weak var ExperienceConten: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
