//
//  AboutHandsyViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AboutHandsyViewController: UIViewController {
    @IBOutlet weak var textViewOut: UIView!{
        didSet {
            self.textViewOut.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutTextView.text = ""
        aboutHandsy()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }

    func aboutHandsy() {
        Alamofire.request("http://smusers.promit2030.com/api/ApiService/AboutHandasy", method: .get, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            let sv = UIViewController.displaySpinner(onView: self.view)
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                self.aboutTextView.text = json.stringValue
                UIViewController.removeSpinner(spinner: sv)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.aboutHandsy()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
    }
}
