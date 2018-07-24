//
//  ReceiveFileChatTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 4/21/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ReceiveFileChatTableViewCell: UITableViewCell {
    @IBOutlet weak var senderMessageView: UIView!{
        didSet {
            DispatchQueue.main.async {
                self.senderMessageView.roundCorners([.bottomLeft, .bottomRight, .topRight], radius: 10)
            }
        }
    }
    @IBOutlet weak var senderMessageFile: UIButton!
    
    @IBOutlet weak var messageTimeLabel: UILabel!

    @IBOutlet weak var fileNameLabel: UILabel!
    
    @IBOutlet weak var fileImageExt: UIImageView!
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
