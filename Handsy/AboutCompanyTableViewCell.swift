//
//  AboutCompanyTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class AboutCompanyTableViewCell: UITableViewCell {
    @IBOutlet weak var ServiceName: UILabel!{
        didSet{
            ServiceName.layer.cornerRadius = 8.0
            ServiceName.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var ServiceNameUIView: UIView!{
        didSet{
            ServiceNameUIView.layer.cornerRadius = 8.0
            ServiceNameUIView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var Content: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
