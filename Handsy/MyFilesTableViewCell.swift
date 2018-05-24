//
//  MyFilesTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/30/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MyFilesTableViewCell: UITableViewCell {
    @IBOutlet weak var myFilesBtn: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.myFilesBtn.layer.cornerRadius = 7.0
                self.myFilesBtn.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var ProjectFiles: UIButton! {
        didSet {
            DispatchQueue.main.async {
                self.ProjectFiles.layer.cornerRadius = 7.0
                self.ProjectFiles.layer.masksToBounds = true
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
