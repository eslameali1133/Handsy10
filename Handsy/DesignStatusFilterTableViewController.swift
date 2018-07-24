//
//  StatusFilterTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class DesignStatusFilterTableViewController: UITableViewController, DesignStatusModelDelegate {
    
    var filterDesignsDelegate: FilterDesignsDelegate?
    var designStatus = [DesignStatus]()
    let designStatusModel = DesignStatusModel()
    
    var type = ""
    var statusId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designStatusModel.delegate = self
        designStatusModel.GetDesignsStatus(view: self.view, VC: self, Type: type)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return designStatus.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell", for: indexPath)
        // Configure the cell...
        if designStatus[indexPath.row].DesignsTypeID == statusId {
            cell.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.5490196078, blue: 0.5529411765, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
        // Configure the cell...
        cell.textLabel?.text = designStatus[indexPath.row].DesignsTypeDetails
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let statusId = designStatus[indexPath.row].DesignsTypeID
        let statusName = designStatus[indexPath.row].DesignsTypeDetails
        self.filterDesignsDelegate?.filterDesignsByStatusId(StatusId: statusId, StatusName: statusName)
        self.dismiss(animated: false, completion: nil)
    }

    func designStatusDataReady() {
        self.designStatus = self.designStatusModel.designStatus
        self.tableView.reloadData()
    }

}
