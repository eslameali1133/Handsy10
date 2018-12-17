//
//  openLocation.swift
//  Handsy
//
//  Created by apple on 12/17/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import Foundation


class Helper {
    
    class func isDeviceiPad() -> Bool {
        return (UIDevice.current.userInterfaceIdiom == .phone) ? false : true
    }
    
}
