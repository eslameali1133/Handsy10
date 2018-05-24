//
//  ProjectsContinueTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/14/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ProjectsContinueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var officeNameLabel: UILabel!
    @IBOutlet weak var ProjectBildTypeName: UILabel!
    @IBOutlet weak var StagesDetailsName: UILabel!
    @IBOutlet weak var CreateDate: UILabel!
    @IBOutlet weak var EmpName: UILabel!
    @IBOutlet weak var Details: UILabel!
    @IBOutlet weak var Status: UIImageView!
    @IBOutlet weak var nameOfStatus: UILabel!
    @IBOutlet weak var CompanyLogoImage: UIImageView!{
        didSet {
            DispatchQueue.main.async {
                self.CompanyLogoImage.layer.cornerRadius = 7.0
                self.CompanyLogoImage.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet weak var BtnOutlet: UIStackView!
    
    @IBOutlet weak var PDF: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.PDF.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }

    @IBOutlet weak var DownPdf: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.DownPdf.circleView(UIColor.clear, borderWidth: 1.0)
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
