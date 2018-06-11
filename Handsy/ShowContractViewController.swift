//
//  ShowContractViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 2/20/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShowContractViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var WebViewContract: UIWebView!
    @IBOutlet weak var AcceptViewOut: UIView!
    @IBOutlet weak var AcceptBtnOut: UIButton!{
        didSet {
            DispatchQueue.main.async {
                self.AcceptBtnOut.layer.cornerRadius = 7.0
                self.AcceptBtnOut.layer.masksToBounds = true
            }
        }
    }
    
    var url: String = ""
    var Webtitle: String = "العقد المقترح"
    var ProjectId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Webtitle
        WebViewContract.delegate = self
        
        if let urlPdf = URL(string: url) {
            let request = URLRequest(url: urlPdf)
            WebViewContract.loadRequest(request)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AcceptContactAction(_ sender: UIButton) {
        AcceptContract()
    }
    
    func AcceptContract() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        let parameters: Parameters = [
            "projectId": ProjectId
        ]
        
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/AcceptContract", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                self.AcceptViewOut.isHidden = true
                self.navigationController!.popViewController(animated: false)
            case .failure(let error):
                print(error)
                UIViewController.removeSpinner(spinner: sv)
                let alertAction = UIAlertController(title: "خطاء في الاتصال", message: "اعادة المحاولة", preferredStyle: .alert)
                
                alertAction.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                    self.AcceptContract()
                }))
                
                alertAction.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { action in
                    
                }))
                
                self.present(alertAction, animated: true, completion: nil)
                
            }
            
        }
        UIViewController.removeSpinner(spinner: sv)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
