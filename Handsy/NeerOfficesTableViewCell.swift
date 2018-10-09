//
//  NeerOfficesTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/14/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class NeerOfficesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Rate: RatingController!
    
    @IBOutlet weak var Rate_Search: RatingController!
    @IBOutlet weak var Office_Rate: FloatRatingView!
    @IBOutlet weak var CompanyLogoImage: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.CompanyLogoImage.layer.cornerRadius = 7.0
                self.CompanyLogoImage.layer.masksToBounds = true
                
            }
        }
    }
    @IBOutlet weak var OfficeName: UIButton!
    @IBOutlet weak var NeerBeLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var chooseBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.chooseBtnOut.layer.cornerRadius = 7.0
                self.chooseBtnOut.layer.masksToBounds = true
                
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
