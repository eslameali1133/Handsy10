//
//  NotCollectedTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class NotCollectedTableViewCell: UITableViewCell {

    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var numberOfDf3A: UILabel!
    @IBOutlet weak var MoneyOfDf3a: UILabel!
    @IBOutlet weak var CompanyNameLabel: UILabel!
    
    @IBOutlet weak var projectDetialOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.projectDetialOut.layer.cornerRadius = 7.0
                self.projectDetialOut.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var contractBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
