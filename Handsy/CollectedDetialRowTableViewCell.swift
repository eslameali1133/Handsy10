//
//  CollectedDetialRowTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/18/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class CollectedDetialRowTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ProjectsPaymentsIdlabel: UILabel!
    @IBOutlet weak var ProjectsPaymentsNumberLabel
    : UILabel!
    @IBOutlet weak var PaymentTypeNameLabel: UILabel!

    
    @IBOutlet weak var PaymentValueLabel: UILabel!
    @IBOutlet weak var PayDate: UILabel!
    @IBOutlet weak var PayDateHijri: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
