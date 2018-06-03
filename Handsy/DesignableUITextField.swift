//
//  TextImage.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/22/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

//@IBDesignable
class DesignableUITextField: UITextField {
    
    // Close Copy And Paste
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //    override func textRect(forBounds bounds: CGRect) -> CGRect {
    //        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 90))
    //    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
    
    // Provides right padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var rightWidth: CGFloat = 20 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightHeight: CGFloat = 20 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var leftWidth: CGFloat = 20 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftHeight: CGFloat = 20 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = rightImage {
            rightViewMode = UITextFieldViewMode.always
            let view = UIView()
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: rightWidth, height: rightHeight))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            view.frame = CGRect(x: 0, y: 0, width: rightWidth+15, height: rightHeight)
            view.addSubview(imageView)
            rightView = view
        } else if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: leftWidth, height: leftHeight))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: color])
    }
}

