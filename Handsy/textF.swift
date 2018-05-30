//
//  textF.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/22/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit


extension UITextField {
    func setBottomBorderGray() {
        self.borderStyle = .none
//        self.layer.backgroundColor = UIColor.black.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func setBottomBorderRed() {
        self.borderStyle = .none
        //        self.layer.backgroundColor = UIColor.black.cgColor
        
        self.layer.masksToBounds = false
        let red = UIColor(red: 230.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        self.layer.shadowColor = red.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func setBottomBorderYellow() {
        self.borderStyle = .none
        self.layer.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        
        self.layer.masksToBounds = false
        let yellow = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
        self.layer.shadowColor = yellow.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    enum Direction
    {
        case left
        case right
    }
    
    func AddImage(_ direction:Direction,imageName:String,Frame:CGRect,backgroundColor:UIColor)
    {
        let View = UIView(frame: Frame)
        View.backgroundColor = backgroundColor
        
        let imageView = UIImageView(frame: Frame)
        imageView.image = UIImage(named: imageName)
        
        View.addSubview(imageView)
        
        if Direction.left == direction
        {
            self.leftViewMode = .always
            self.leftView = View
        }
        else
        {
            self.rightViewMode = .always
            self.rightView = View
        }
    }

    
}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(_ textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        let c = self.characters
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
}



