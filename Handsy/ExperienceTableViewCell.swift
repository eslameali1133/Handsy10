//
//  ExparTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 11/9/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var ExperienceTit: UILabel!{
        didSet{
            ExperienceTit.layer.cornerRadius = 8
             ExperienceTit.layer.masksToBounds = true
        }}
    @IBOutlet weak var Servicetitle: UILabel!{
        didSet{
            Servicetitle.layer.cornerRadius = 8
             Servicetitle.layer.masksToBounds = true
        }}
    @IBOutlet weak var ExperienceConten: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var titleview: UIView!{
        didSet{
            titleview.layer.cornerRadius = 8
        }}

    @IBOutlet weak var Stack3: UIStackView!{
    didSet{
    Stack3.layer.cornerRadius = 8
        }}

    @IBOutlet weak var Stack2: UIStackView! {
        didSet{
            Stack2.layer.cornerRadius = 8
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
