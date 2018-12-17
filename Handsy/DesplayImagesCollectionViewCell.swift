//
//  DesplayImagesCollectionViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/23/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class DesplayImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!{
        didSet{
            imageView.layer.cornerRadius = 10
        }
    }
    
}
