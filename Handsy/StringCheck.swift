//
//  StringCheck.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/23/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit


extension String {
    func substring(_ fromPosition: UInt, toPosition: UInt) -> String? {
        guard fromPosition <= toPosition else {
            return nil
        }
        
        guard toPosition < UInt(characters.count) else {
            return nil
        }
        
        let start = index(startIndex, offsetBy: String.IndexDistance(fromPosition))
        let end   = index(startIndex, offsetBy: String.IndexDistance(toPosition) + 1)
        let range = start..<end
        
        return substring(with: range)
    }
    
    func letterize() -> [Character] {
        return Array(self.characters)
    }
}

class StringCheck: NSObject {

}
