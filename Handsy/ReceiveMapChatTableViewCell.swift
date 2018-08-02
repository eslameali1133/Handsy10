//
//  ReceiveMapChatTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/23/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ReceiveMapChatTableViewCell: UITableViewCell {
    @IBOutlet weak var senderMessageView: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.senderMessageView.roundCorners([.bottomLeft, .bottomRight, .topRight], radius: 10)
            }
        }
    }
    @IBOutlet weak var senderMessageImage: UIImageView!
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
