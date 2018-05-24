//
//  BranchSectionTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 11/29/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class BranchSectionTableViewCell: UITableViewCell {
    @IBOutlet weak var BranchName: UILabel!
    @IBOutlet weak var expandImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
