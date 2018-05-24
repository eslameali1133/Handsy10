//
//  ImageCollectionViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/25/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var PlusImage: UIImageView!
    @IBOutlet weak var delete: UIButton!

    
    func configurecell(_ image: UIImage){
        
        
        imageView.image = image
        
    }
}
