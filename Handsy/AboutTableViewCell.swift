//
//  AboutTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 11/9/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {

    @IBOutlet weak var AboutTit: UILabel!{
        didSet{
            AboutTit.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var titleview: UIView!{
        didSet{
            titleview.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var AboutConten: UITextView!
    
    @IBOutlet weak var Stackone: UIStackView!
        {
        didSet{
            Stackone.layer.cornerRadius = 8
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
