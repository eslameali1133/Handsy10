//
//  OfficesImagesCollectionViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 12/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class OfficesImagesCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    func configureCell(image: String){
        let trimmedString = image.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = URL.init(string: trimmedString!)
        imageView.hnk_setImageFromURL(url!, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        self.scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
        return self.imageView
    }
}
