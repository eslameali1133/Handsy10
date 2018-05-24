//
//  MomeyManagmentViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/16/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MomeyManagmentViewController: UIViewController {
    @IBOutlet weak var DontCollectedView: UIView!
    let collectedTableViewController : CollectedTableViewController = CollectedTableViewController()
    let notCollectedTableViewController : NotCollectedTableViewController = NotCollectedTableViewController()
    @IBOutlet weak var CollectedView: UIView!
    @IBAction func Segment(_ sender: AWSegmentMoney) {
        switch Segm.selectedIndex
        {
        case 0:
            CollectedView.isHidden = true
            DontCollectedView.isHidden = false
        case 1:
            CollectedView.isHidden = false
            DontCollectedView.isHidden = true
        default:
            break;
        }
        
    }
    @IBOutlet weak var Segm: AWSegmentMoney!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Segm.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
        navigationItem.title = "الماليات والعقد"
//        assignbackground()
        CollectedView.isHidden = false
        DontCollectedView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func assignbackground(){
        DispatchQueue.main.async {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "splash"))
            imageView.contentMode = .scaleAspectFill
            self.view.insertSubview(imageView, at: 0)
            self.view.sendSubview(toBack: imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            imageView.layoutIfNeeded()
        }
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
