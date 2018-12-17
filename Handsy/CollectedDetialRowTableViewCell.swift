//
//  CollectedDetialRowTableViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/18/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

protocol GotoEsal {
    func GotoEsalView(urlEsla: String)
}

class CollectedDetialRowTableViewCell: UITableViewCell {

     
    @IBOutlet weak var ProjectsPaymentsIdlabel: UILabel!
    @IBOutlet weak var ProjectsPaymentsNumberLabel
    : UILabel!
    @IBOutlet weak var PaymentTypeNameLabel: UILabel!

    var eslaurl = ""
    @IBOutlet weak var PaymentValueLabel: UILabel!
    @IBOutlet weak var PayDate: UILabel!
    @IBOutlet weak var PayDateHijri: UILabel!
    var delegate : GotoEsal?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func GotoEsal(_ sender: Any) {
  
        if delegate != nil {
            delegate?.GotoEsalView(urlEsla: eslaurl)
        }
    }
}
    extension CollectedDetialRowTableViewCell:GotoEsal{
        func GotoEsalView(urlEsla: String) {
            
            if delegate != nil {
                delegate?.GotoEsalView(urlEsla: eslaurl)
            }
        
        }
        
}
