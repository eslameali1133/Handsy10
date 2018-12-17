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
    var url: String = ""
    var documentInteractionController = UIDocumentInteractionController()
    var imagePath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url = imagePath
        configureCell(imagePath)
        // Do any additional setup after loading the view.
         downloadPdf()
    }
    func downloadPdf()  {
        let download = UIButton(type: .custom)
        download.setImage(UIImage (named: "download-button-1"), for: .normal)
        download.tintColor = UIColor.white
        download.widthAnchor.constraint(equalToConstant: 30).isActive = true
        download.heightAnchor.constraint(equalToConstant: 30).isActive = true
        download.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        download.addTarget(self, action:#selector(downloadPdfButton), for: .touchUpInside)
        
        let barButtonItem2 = UIBarButtonItem(customView: download)
        barButtonItem2.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [ barButtonItem2]
    }
    @objc func downloadPdfButton(sender: UIButton) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "Contract.pdf")
            do {
                try data.write(to: tmpURL)
            } catch { print(error) }
            DispatchQueue.main.async {
                self.share(url: tmpURL)
            }
            }.resume()
    }
    func share(url: URL) {
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentOptionsMenu(from: view.frame, in: view, animated: true)
    }
    func configureCell(_ image: String){
        let trimmedString = image.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let url = URL.init(string: trimmedString!) {
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
