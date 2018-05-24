//
//  NewMyProjectsTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/27/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class NewMyProjectsTableViewCell: UITableViewCell {
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var StatusNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var EngNameLabel: UILabel!
    @IBOutlet weak var DateRegisterLabel: UILabel!
    
    
    @IBOutlet weak var callBtn: UIButton! {
        didSet {
            callBtn.layer.borderWidth = 1.0
            callBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            callBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var officeDetialsBtn: UIButton! {
        didSet {
            officeDetialsBtn.layer.borderWidth = 1.0
            officeDetialsBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            officeDetialsBtn.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var messageWithEng: UIButton! {
        didSet {
            messageWithEng.layer.borderWidth = 1.0
            messageWithEng.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            messageWithEng.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var backgroundCellView: UIView!
    
    @IBOutlet weak var EmpImageOut: AMCircleImageView!
    
    @IBOutlet weak var lastStatusLabel: UILabel!
    @IBOutlet weak var notficationAlertBtnOut: UIButton!
    @IBOutlet weak var notficationCountLabel: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.notficationCountLabel.layer.cornerRadius = self.notficationCountLabel.frame.width/2
                self.notficationCountLabel.layer.masksToBounds = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notficationAlertBtnOut.isHidden = true
        notficationCountLabel.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
