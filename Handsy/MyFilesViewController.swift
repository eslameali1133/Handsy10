//
//  MyFilesViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/30/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MyFilesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RequestProjectModelDelegate {
    @IBOutlet weak var myFilesTableView: UITableView!
    
    var searchResu:[GetProjectEngCustByCustID] = [GetProjectEngCustByCustID]()
    
    let model: RequestProjectModel = RequestProjectModel()
    
    let projectModel : projectsModel = projectsModel()
    
    @IBOutlet weak var NothingLabel: UILabel!
    @IBOutlet weak var AlertImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.NothingLabel.isHidden = true
            self.AlertImage.isHidden = true
        }
        //        assignbackground()
        myFilesTableView.delegate = self
        myFilesTableView.dataSource = self
        
        model.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            model.GetProjectByCustID(view: self.view, VC: self)
        }else{
            print("Internet Connection not Available!")
            projectModel.loadItems()
            self.searchResu = projectModel.projects
            myFilesTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReady() {
        // Access the video objects that have been downloaded
        self.searchResu = self.model.resultArray
        // Tell the tableview to reload
        self.myFilesTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchResu.count == 0 {
            NothingLabel.isHidden = false
            AlertImage.isHidden = false
            myFilesTableView.isHidden = true
        } else {
            myFilesTableView.isHidden = false
            NothingLabel.isHidden = true
            AlertImage.isHidden = true
        }
        return searchResu.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let obj = searchResu[section]
        return obj.isSelected ? 1 : 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 20
    //    }
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let view = UIView()
    //        view.backgroundColor = UIColor.clear
    //        return view
    //    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFilesSectionTableViewCell") as! MyFilesSectionTableViewCell
        cell.projectTitle.text = searchResu[section].ProjectTitle
        cell.officeNameLabel.text = searchResu[section].ComapnyName
        cell.EngnameLabel.text = searchResu[section].EmpName
        
        if searchResu[section].SakNum != ""
        {
            cell.SakNumberLabel.text = searchResu[section].SakNum
        }else
        {
          cell.SakNumberLabel.text = searchResu[section].ProjectId
        }
        cell.contentView.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
        cell.layer.cornerRadius = 7
        cell.layer.borderColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0).cgColor // set cell border color here
        cell.layer.masksToBounds = true
        if self.searchResu[section].isSelected == true {
            cell.expandingImage.image = #imageLiteral(resourceName: "remove")
        } else{
            cell.expandingImage.image = #imageLiteral(resourceName: "add-plus-button (1)")
        }
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.didSelectASection))
        cell.contentView.addGestureRecognizer(tapGest)
        cell.contentView.tag = section
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = myFilesTableView.dequeueReusableCell(withIdentifier: "MyFilesTableViewCell", for: indexPath) as! MyFilesTableViewCell
        cell.contentView.backgroundColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0)
        cell.layer.cornerRadius = 7
        cell.layer.borderColor = UIColor(red: 58/255.0, green: 59/255.0, blue: 60/255.0, alpha: 1.0).cgColor // set cell border color here
        cell.layer.masksToBounds = true
        return cell
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
    
    @objc func didSelectASection(tapGest: UITapGestureRecognizer) {
        let section = tapGest.view!.tag
        let obj = self.searchResu[section]
        self.searchResu[section].isSelected = !obj.isSelected
        self.myFilesTableView.reloadData()
    }
    @IBAction func MyFilesBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: myFilesTableView)
        let index = myFilesTableView.indexPathForRow(at: point)?.section
        if searchResu[index!].ProjectFileCount == "0" {
            Toast.long(message: "لايوجد وثائق للارض")
        }else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "MyFilesAndMoney", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "ProjectFilesViewController") as! ProjectFilesViewController
            secondView.ProjectId = searchResu[index!].ProjectId
            secondView.projectTitleView = searchResu[index!].ProjectTitle
            secondView.type = "1"
            secondView.ProjectFilesTitle = "وثائق الأرض"
            secondView.ComapnyName = searchResu[index!].ComapnyName
            secondView.Address = searchResu[index!].Address
            secondView.EmpName = searchResu[index!].EmpName
            secondView.EmpMobile = searchResu[index!].EmpMobile
            secondView.Logo = searchResu[index!].Logo
            myFilesTableView.reloadData()
            self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
    
    @IBAction func ProjectFilesBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: myFilesTableView)
        let index = myFilesTableView.indexPathForRow(at: point)?.section
        if searchResu[index!].FileCount == "0" {
            Toast.long(message: "لايوجد ملفات للمشروع")
        }else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "MyFilesAndMoney", bundle:nil)
            let secondView = storyBoard.instantiateViewController(withIdentifier: "ProjectFilesViewController") as! ProjectFilesViewController
            secondView.ProjectId = searchResu[index!].ProjectId
            secondView.projectTitleView = searchResu[index!].ProjectTitle
            secondView.type = "2"
            secondView.ProjectFilesTitle = "ملفات المشروع"
            secondView.ComapnyName = searchResu[index!].ComapnyName
            secondView.Address = searchResu[index!].Address
            secondView.EmpName = searchResu[index!].EmpName
            secondView.EmpMobile = searchResu[index!].EmpMobile
            secondView.Logo = searchResu[index!].Logo
            myFilesTableView.reloadData()
            self.navigationController?.pushViewController(secondView, animated: true)
        }
    }
  
    
    @IBAction func ProjectDetailsBtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: myFilesTableView)
        let index = myFilesTableView.indexPathForRow(at: point)?.section
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
        let proId = searchResu[index!].ProjectId
        print("pro" + proId)
        print("ind" + "\(index)")
        secondView.ProjectId = proId
        secondView.norma = "Hi"
        secondView.ProjectTitle = searchResu[index!].ProjectTitle
        self.navigationController?.pushViewController(secondView, animated: true)
        
    }
    
}
