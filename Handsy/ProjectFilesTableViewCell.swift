//
//  ProjectFilesTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 10/1/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ProjectFilesTableViewCell: UITableViewCell {
    @IBOutlet weak var ProjectTitle: UILabel!
    @IBOutlet weak var visibileBtn: UIButton!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var uploadFileStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        uploadFileStack.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
