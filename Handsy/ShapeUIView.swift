//
//  ShapeUIView.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/27/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import Foundation

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
//    YourView.roundCorners([.topLeft, .bottomLeft], radius: 10)
}
