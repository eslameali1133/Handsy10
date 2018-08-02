//
//  ProfileImageViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/20/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ProfileImageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollViewOut: UIScrollView!
    @IBOutlet weak var ProfileImgOut: UIImageView!
    
    var imagePath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell(imagePath)
        // Do any additional setup after loading the view.
    }

    func configureCell(_ image: String){
        let trimmedString = image.trimmingCharacters(in: .whitespaces)
        if let url = URL.init(string: trimmedString) {
            print(url)
            ProfileImgOut.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "custlogo"))
        } else{
            ProfileImgOut.image = #imageLiteral(resourceName: "custlogo")
            print("nil")
        }
        self.scrollViewOut.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        self.scrollViewOut.minimumZoomScale = 1.0
        self.scrollViewOut.maximumZoomScale = 6.0
        
        return self.ProfileImgOut
    }

}
