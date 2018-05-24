//
//  ImagesEditCollectionViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/7/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ImagesEditCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var delete: UIButton!
    
    
    func configurecell(_ image: UIImage){
        
        imageView.image = image
        
    }

}
