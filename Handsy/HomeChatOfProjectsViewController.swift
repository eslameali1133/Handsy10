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
    var filterdAllHomeMessage = [AllHomeMessage]()
    var allHomeMessageModel = AllHomeMessageModel()
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        addBackBarButtonItem()
        alertImage.isHidden = true
        alertLabel.isHidden = true
        chatOfProjectsTableView.delegate = self
        chatOfProjectsTableView.dataSource = self
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "ابحث عن المشروع"
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        // Prevent the navigation bar from being hidden when searching.
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    func addBackBarButtonItem() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "BackGray"), for: .normal)
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        allHomeMessageModel.delegate = self
        allHomeMessageModel.AllMessageListForCust(view: self.view, VC: self, type: "", projectTitle: "") { (Results) in
            self.allHomeMessage = Results
            if self.allHomeMessage.count == 0 {
                self.alertImage.isHidden = false
                self.alertLabel.isHidden = false
                self.chatOfProjectsTableView.isHidden = true
            }else {
                self.alertImage.isHidden = true
                self.alertLabel.isHidden = true
                self.chatOfProjectsTableView.isHidden = false
            }
            self.chatOfProjectsTableView.reloadData()
        }
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
        if isFiltering() {
            return filterdAllHomeMessage.count
        }else{
            return allHomeMessage.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeChatOfProjectsTableViewCell", for: indexPath) as! HomeChatOfProjectsTableViewCell
        var message = AllHomeMessage()
        if isFiltering() {
            message = filterdAllHomeMessage[indexPath.section]
        }else {
            message = allHomeMessage[indexPath.section]
        }
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
        let trimmedString = companyImg.trimmingCharacters(in: .whitespaces)
        if let url = URL.init(string: trimmedString) {
            cell.companyImage.hnk_setImageFromURL(url, placeholder: #imageLiteral(resourceName: "officePlaceholder"))
        } else{
            cell.companyImage.image = #imageLiteral(resourceName: "officePlaceholder")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var message = AllHomeMessage()
        if isFiltering() {
            message = filterdAllHomeMessage[indexPath.section]
        }else {
            message = allHomeMessage[indexPath.section]
        }
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
        FirstViewController.ProjectId = message.ProjectId
        FirstViewController.engName = message.SenderName
        FirstViewController.engImage = message.SenderImage
        self.navigationController?.pushViewController(FirstViewController, animated: true)
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        //        filteredOffices = arrayOfResulr.filter({( candy : GetOfficesArray) -> Bool in
        //            return candy.ComapnyName.lowercased().contains(searchText.lowercased())
        //        })
        allHomeMessageModel.AllMessageListForCust(view: self.view, VC: self, type: "search", projectTitle: searchText) { (Results) in
            self.filterdAllHomeMessage = Results
            self.chatOfProjectsTableView.reloadData()
        }
    }
    
    @IBAction func detialsOfProjects(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: chatOfProjectsTableView)
        let index = chatOfProjectsTableView.indexPathForRow(at: point)?.section
        var message = AllHomeMessage()
        if isFiltering() {
            message = filterdAllHomeMessage[index!]
        }else {
            message = allHomeMessage[index!]
        }
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
        var message = AllHomeMessage()
        if isFiltering() {
            message = filterdAllHomeMessage[index!]
        }else {
            message = allHomeMessage[index!]
        }
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let FirstViewController = storyboard.instantiateViewController(withIdentifier: "ChatOfProjectsViewController") as! ChatOfProjectsViewController
        FirstViewController.ProjectId = message.ProjectId
        FirstViewController.engName = message.SenderName
        FirstViewController.engImage = message.SenderImage
        self.navigationController?.pushViewController(FirstViewController, animated: true)
    }
    
}
extension HomeChatOfProjectsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
