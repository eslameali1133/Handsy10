//
//  ImageZoomingViewController.swift
//  Handsy
//
//  Created by apple on 12/2/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Haneke

class ImageZoomingViewController: UIViewController ,UIScrollViewDelegate{

    var Downloadurlforshare = ""
    @IBOutlet weak var Imageview: UIImageView!
    @IBOutlet weak var ScrollerView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollerView.delegate = self
self.ScrollerView.minimumZoomScale = 1.0
        self.ScrollerView.maximumZoomScale = 6.0
        
        
        // Do any additional setup after loading the view.
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.Imageview
    }

    @IBAction func shareBtnAction(_ sender: UIButton) {
        DownloadandShareSold()
    }
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func DownloadandShareSold()
    {
        
        let messagePic = Downloadurlforshare
        
        
        
        guard let url = URL(string:self.Downloadurlforshare) else { return }
        print(url)
        
        var Filename = ""
        if let range = messagePic.range(of: "Images/") {
            Filename = String(messagePic[range.upperBound...])
            print(Filename.encodeUrl()) // prints "123.456.7891"
        }
        
        let FilenameFinal =  Filename
        //            Filename.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
        print(FilenameFinal)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(FilenameFinal ?? "Contract.jpeg")
            do {
                try data.write(to: tmpURL)
            } catch { print(error) }
            DispatchQueue.main.async {
                self.share(url: tmpURL)
            }
            }.resume()
    }
    
    var documentInteractionController = UIDocumentInteractionController()
    func share(url: URL) {
        print(url)
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentOptionsMenu(from: view.frame, in: view, animated: true)
    }
    
}
