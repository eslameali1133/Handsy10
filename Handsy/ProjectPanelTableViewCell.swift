//
//  ProjectPanelTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/23/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ProjectPanelTableViewCell: UITableViewCell {

    @IBOutlet weak var ProvincesName: UILabel!
    @IBOutlet weak var SectoinName: UILabel!
    @IBOutlet weak var ProjectsOrdersCellarErea: UILabel!
    @IBOutlet weak var ProjectsOrdersReFloorErea: UILabel!
    
    @IBOutlet weak var ProjectsOrdersSupplementErea: UILabel!
    
    @IBOutlet weak var ProjectsOrdersSupplementExternalErea: UILabel!
    
    @IBOutlet weak var ProjectsOrdersFloorErea: UILabel!
    
    @IBOutlet weak var ProjectsOrdersLandErea: UILabel!
    
    @IBOutlet weak var ProjectsOrdersFloorNummber: UILabel!
    
    @IBOutlet weak var ProjectsOrdersTotalBildErea: UILabel!
    @IBOutlet weak var ProjectsPaymentsWork: UILabel!
    
    @IBOutlet weak var ProjectsPaymentsDiscount: UILabel!
    
    @IBOutlet weak var ProjectsPaymentsCost: UILabel!
    
    @IBOutlet weak var AlertCodeLabel: UILabel!
    @IBOutlet weak var AlertImageOut: UIImageView!
    
    @IBOutlet weak var contentStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
