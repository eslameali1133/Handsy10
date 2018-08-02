//
//  CustomInfoWindow.swift
//  CustomInfoWindow
//
//  Created by Malek T. on 12/13/15.
//  Copyright © 2015 Medigarage Studios LTD. All rights reserved.
//

import UIKit

class CustomInfoWindow: UIView {

    @IBOutlet weak var chooseOfficeOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.chooseOfficeOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    @IBOutlet weak var OfficeDetialsOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.OfficeDetialsOut.circleView(UIColor.clear, borderWidth: 1.0)
            }
        }
    }
    
    @IBOutlet var completedYearLbl: UILabel!
    @IBOutlet var architectLbl: UILabel!
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

