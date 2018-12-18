//
//  ReceiveImageChatTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 4/21/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ReceiveImageChatTableViewCell: UITableViewCell {
    @IBOutlet weak var senderMessageView: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.senderMessageView.roundCorners([.bottomLeft, .bottomRight, .topRight], radius: 10)
            }
        }
    }
    @IBOutlet weak var senderMessageImage: customImageView!
    @IBOutlet weak var messageTimeLabel: UILabel!

    @IBOutlet weak var senderNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
