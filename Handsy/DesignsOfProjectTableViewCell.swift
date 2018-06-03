//
//  DesignsOfProjectTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/31/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class DesignsOfProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var StagesDetailsName: UILabel!
    @IBOutlet weak var CreateDate: UILabel!
    @IBOutlet weak var Details: UILabel!
    @IBOutlet weak var Status: UIImageView!
    @IBOutlet weak var nameOfStatus: UILabel!
    @IBOutlet weak var EmpMobile: UIButton!
    
    @IBOutlet weak var BtnOutlet: UIButton!{
        didSet {
            BtnOutlet.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var messageChat: UIButton!{
        didSet {
            messageChat.layer.borderWidth = 1.0
            messageChat.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            messageChat.layer.cornerRadius = 4.0
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
