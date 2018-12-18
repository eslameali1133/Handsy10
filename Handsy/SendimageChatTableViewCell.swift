//
//  SendimageChatTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 4/21/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class SendimageChatTableViewCell: UITableViewCell {
    @IBOutlet weak var recevierMessageView: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.recevierMessageView.roundCorners([.bottomLeft, .bottomRight, .topLeft], radius: 10)
            }
        }
    }
    @IBOutlet weak var recevierMessageImage: customImageView!
    @IBOutlet weak var messageTimeLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
