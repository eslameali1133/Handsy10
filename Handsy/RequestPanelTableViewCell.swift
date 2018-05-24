//
//  RequestPanelTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/23/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class RequestPanelTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfProject: UILabel!
    @IBOutlet weak var nameOfStatus: UILabel!
    @IBOutlet weak var imageOfStatus: UIImageView!
    @IBOutlet weak var projectType: UILabel!
    @IBOutlet weak var numberOfSake: UILabel!
    @IBOutlet weak var numberPlan: UILabel!
    @IBOutlet weak var space: UILabel!
    @IBOutlet weak var numberLicence: UILabel!
    @IBOutlet weak var numberALlmogh: UILabel!
    @IBOutlet weak var customerDetials: UITextView!
    @IBOutlet weak var dataOfSak: UILabel!
    @IBOutlet weak var dataOfLicence: UILabel!
    @IBOutlet weak var EngNotes: UITextView!
    @IBOutlet weak var EngNotesStack: UIStackView!
    @IBOutlet weak var EngNotesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
