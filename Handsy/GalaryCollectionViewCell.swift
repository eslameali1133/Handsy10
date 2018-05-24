//
//  GalaryCollectionViewCell.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/26/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class GalaryCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    func configurecell(_ image: UIImage){
        
        imageView.image = image

        self.scrollView.delegate = self
    }
    
    func configureCell(_ image: String){
        let url = URL.init(string: image)
        imageView.hnk_setImageFromURL(url!, placeholder: #imageLiteral(resourceName: "custlogo"))
        
        self.scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
        return self.imageView
    }
}
