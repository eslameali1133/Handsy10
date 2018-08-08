//
//  MyProjectNotficationTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/29/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MyProjectNotficationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notficationTitleLabel: UILabel!
    @IBOutlet weak var notficationTimeLabel: UILabel!
    @IBOutlet weak var newNotficationBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.newNotficationBtn.layer.cornerRadius = 6.0
                self.newNotficationBtn.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var notficationDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        notficationTimeLabel.isHidden = true
        newNotficationBtn.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
