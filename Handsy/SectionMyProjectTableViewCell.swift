//
//  SectionMyProjectTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 5/16/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class SectionMyProjectTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundCellView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.backgroundCellView.roundCorners([.topLeft, .topRight], radius: 5)
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
