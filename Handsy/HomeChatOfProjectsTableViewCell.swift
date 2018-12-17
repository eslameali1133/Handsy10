//
//  HomeChatOfProjectsTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/5/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class HomeChatOfProjectsTableViewCell: UITableViewCell {
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var dateOfMessageLabel: UILabel!
    @IBOutlet weak var messageCountLabel: UILabel!
    
    @IBOutlet weak var SakNumber: UILabel!
    @IBOutlet weak var messageCountView: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.messageCountView.layer.cornerRadius = self.messageCountView.bounds.height/2
            }
        }
    }
    
//    @IBOutlet weak var detialsBtn: UIButton! {
//        didSet {
//            detialsBtn.layer.borderWidth = 1.0
//            detialsBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
//            detialsBtn.layer.cornerRadius = 4.0
//        }
//    }
//    
//    @IBOutlet weak var chatBtn: UIButton! {
//        didSet {
//            chatBtn.layer.borderWidth = 1.0
//            chatBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
//            chatBtn.layer.cornerRadius = 4.0
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
