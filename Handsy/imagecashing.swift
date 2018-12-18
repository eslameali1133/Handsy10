//
//  imagecashing.swift
//  Handsy
//
//  Created by apple on 12/3/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import Foundation




let imageCash = NSCache<AnyObject, AnyObject>()

class customImageView: UIImageView{
    var imageUrlString : String?
    //use setup image to download from api
    func loadimageUsingUrlString(url:String){
        
        imageUrlString = url
        
        let Url = URL(string:url)
        let urlRequest = URLRequest(url: Url!)
        
        image = #imageLiteral(resourceName: "officePlaceholder")
        if let imageForCash = imageCash.object(forKey: Url as AnyObject) as? UIImage{
            
            self.image = imageForCash
            return
        }
        
        //        self.image = #imageLiteral(resourceName: "officePlaceholder")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            // check for any errors
            guard error == nil else{
                print("Error :Calling API")
                print(error!)
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    
                    let imageToCash = UIImage(data: data!)
                    
                    if self.imageUrlString == url{
                        self.image = imageToCash
                    }
                    
                    if imageToCash != nil
                    {
                        imageCash.setObject(imageToCash!, forKey: Url as AnyObject)
                    }else
                    {
                        self.image = #imageLiteral(resourceName: "officePlaceholder")
                    }
                }
                
                
            }
            
            
            
            
        }
        
        task.resume()
        
    }
    
}


