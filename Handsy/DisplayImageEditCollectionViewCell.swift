//
//  DisplayImageEditCollectionViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/26/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class DisplayImageEditCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var delete: UIButton!
    
    
    func configurecell(_ image: UIImage){
        
        
        imageView.image = image
        
    }

}
