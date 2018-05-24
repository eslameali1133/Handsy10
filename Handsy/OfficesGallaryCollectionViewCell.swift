//
//  OfficesGallaryCollectionViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class OfficesGallaryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(image: String){
        let url = URL.init(string: image)
        imageView.hnk_setImageFromURL(url!, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
    }
}
