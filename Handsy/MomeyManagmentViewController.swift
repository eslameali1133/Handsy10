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
    @IBOutlet var navViewOut: UIView!
    @IBOutlet weak var titleVCLabel: UILabel!
    @IBOutlet weak var callBtn: UIButton!{
        didSet {
            callBtn.layer.borderWidth = 1.0
            callBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            callBtn.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var messageBtn: UIButton!{
        didSet {
            messageBtn.layer.borderWidth = 1.0
            messageBtn.layer.borderColor = #colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.3882352941, alpha: 1)
            messageBtn.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet weak var messageNotfiCount: UILabel!{
        didSet {
            DispatchQueue.main.async {
                self.messageNotfiCount.layer.cornerRadius = self.messageNotfiCount.frame.width/2
                self.messageNotfiCount.layer.masksToBounds = true
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageNotfiCount.isHidden = true
        Segm.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
        navigationItem.title = "الماليات والعقد"
//        assignbackground()
        CollectedView.isHidden = false
        DontCollectedView.isHidden = true
        DispatchQueue.main.async {
            self.navViewOut.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 32)
            self.navViewOut.widthAnchor.constraint(equalToConstant: self.view.frame.width-20).isActive = true
            self.navigationItem.titleView = self.navViewOut
        }
        
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
    
    @IBAction func callBtnAction(_ sender: UIButton) {
        callButtonPressed()
    }
    
    @IBAction func homeChatAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "HomeChatOfProjectsViewController") as! HomeChatOfProjectsViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    @objc func callButtonPressed() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ContactUSViewController") as! ContactUSViewController
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
}
