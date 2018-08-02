//
//  DesignsStatusFilterTableViewController.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MeetingStatusFilterTableViewController: UITableViewController, MeetingStatusModelDelegate {
    var filterVisitsDelegate: FilterVisitsDelegate?
    var meetingStatus = [MeetingStatus]()
    let meetingStatusModel = MeetingStatusModel()
    var type = ""
    var statusId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meetingStatusModel.delegate = self
        meetingStatusModel.GetMeetingsStatus(view: self.view, VC: self, Type: type)
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
        return meetingStatus.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StaticStatusCell", for: indexPath)
        // Configure the cell...
        if meetingStatus[indexPath.row].MeetingTypeID == statusId {
            cell.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.5490196078, blue: 0.5529411765, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
        // Configure the cell...
        cell.textLabel?.text = meetingStatus[indexPath.row].MeetingTypeDetails

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let statusId = meetingStatus[indexPath.row].MeetingTypeID
        let statusName = meetingStatus[indexPath.row].MeetingTypeDetails
        self.filterVisitsDelegate?.filterVisitsByStatusId(StatusId: statusId, StatusName: statusName)
        self.dismiss(animated: false, completion: nil)
    }
    
    func meetingStatusDataReady() {
        self.meetingStatus = self.meetingStatusModel.meetingStatus
        self.tableView.reloadData()
    }
}
