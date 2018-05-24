//
//  MyProjectNotficationTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/29/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MyProjectNotficationTableViewCell: UITableViewCell {
    @IBOutlet weak var companyLogoImg: AMCircleImageView!
    @IBOutlet weak var notficationLightView: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.notficationLightView.layer.cornerRadius = self.notficationLightView.frame.width/2
                self.notficationLightView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.notficationLightView.layer.borderWidth = 1.0
                self.notficationLightView.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var notficationTitleLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
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
