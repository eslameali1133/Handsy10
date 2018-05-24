//
//  CustomTextField.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/22/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    var bottomBorder = UIView()
    
    override func awakeFromNib() {
        
        // Setup Bottom-Border
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9725490196, blue: 0.9607843137, alpha: 1) // Set Border-Color UIColor(colorLiteralRed: 249    , green: 248, blue: 245, alpha: 1)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomBorder)
        
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
        
    }
    
    @IBInspectable var hasError: Bool = false {
        didSet {
            
            if (hasError) {
                
                bottomBorder.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
//                    UIColor(colorLiteralRed: 230, green: 76, blue: 60, alpha: 1)
                
            } else {
                
                bottomBorder.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9725490196, blue: 0.9607843137, alpha: 1)
//                    UIColor(colorLiteralRed: 249    , green: 248, blue: 245, alpha: 1) // Set Border-Color
                
            }
            
        }
    }
}
