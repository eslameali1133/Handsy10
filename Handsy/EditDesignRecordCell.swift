//
//  EditDesignRecordCell.swift
//  Handsy
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class EditDesignRecordCell: UITableViewCell {

    
    @IBOutlet weak var ViewDesignBtn: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.ViewDesignBtn.layer.cornerRadius = 8
                self.ViewDesignBtn.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var note: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
