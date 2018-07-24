//
//  HomeChatOfProjectsViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/5/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class HomeChatOfProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AllHomeMessageModelDelegate {
    
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var chatOfProjectsTableView: UITableView!
    var allHomeMessage = [AllHomeMessage]()
    var allHomeMessageModel = AllHomeMessageModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        alertImage.isHidden = true
        alertLabel.isHidden = true
        chatOfProjectsTableView.delegate = self
        chatOfProjectsTableView.dataSource = self        
    }
    override func viewWillAppear(_ animated: Bool) {
        allHomeMessageModel.delegate = self
        allHomeMessageModel.AllMessageListForCust(view: self.view, VC: self)
    }
    func homeMessageData() {
        self.allHomeMessage = self.allHomeMessageModel.allHomeMessage
        if self.allHomeMessage.count == 0 {
            alertImage.isHidden = false
            alertLabel.isHidden = false
            chatOfProjectsTableView.isHidden = true
        }else {
            alertImage.isHidden = true
            alertLabel.isHidden = true
            chatOfProjectsTableView.isHidden = false
        }
        self.chatOfProjectsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allHomeMessage.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeChatOfProjectsTableViewCell", for: indexPath) as! HomeChatOfProjectsTableViewCell
        let message = allHomeMessage[indexPath.section]
        cell.projectTitleLabel.text = message.SenderName
        cell.lastMessageLabel.text = message.Message
        cell.dateOfMessageLabel.text = message.MessageTime
        if message.NotiCount == "0" || message.NotiCount == ""{
           cell.messageCountView.isHidden = true
        } else {
            cell.messageCountView.isHidden = false
        }
        cell.messageCountLabel.text = message.NotiCount
        let companyImg = message.SenderImage
        if let url = URL.init(string: companyImg) {
            cell.companyImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            cell.companyImage.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = allHomeMessage[indexPath.section]
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
        FirstViewController.ProjectId = message.ProjectId
        FirstViewController.engName = message.SenderName
        FirstViewController.engImage = message.SenderImage
        let topController = UIApplication.topViewController()
        topController?.present(FirstViewController, animated: false, completion: nil)
    }
    
    @IBAction func detialsOfProjects(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: chatOfProjectsTableView)
        let index = chatOfProjectsTableView.indexPathForRow(at: point)?.section
        let message = allHomeMessage[index!]
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let sub = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        sub.nou = "LOl"
        sub.nour = "loll"
        sub.ProjectId = message.ProjectId
        self.navigationController?.pushViewController(sub, animated: true)
    }
    
    
    @IBAction func openMessage(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: chatOfProjectsTableView)
        let index = chatOfProjectsTableView.indexPathForRow(at: point)?.section
        let message = allHomeMessage[index!]
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
        FirstViewController.ProjectId = message.ProjectId
        FirstViewController.engName = message.SenderName
        FirstViewController.engImage = message.SenderImage
        let topController = UIApplication.topViewController()
        topController?.present(FirstViewController, animated: false, completion: nil)
    }
    
}
