//
//  AllNotfications.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/29/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MyProjectNotfications: NSObject {
    var ComapnyName: String?
    var CompanyLogo: String?
    var Desc: String?
    var DesignStagesID: String?
    var IsRead: String?
    var MeetingID: String?
    var NotificationID: String?
    var NotificationTypeID: String?
    var Other: String?
    var ProjectId: String?
    var ProjectTitle: String?
    var TimeAgo: String?
    var DateCreate: String?
    var ProjectContract: String?
    init(ComapnyName: String, CompanyLogo: String, Desc: String, DesignStagesID: String, IsRead: String, MeetingID: String, NotificationID: String, NotificationTypeID: String, Other: String, ProjectId: String, ProjectTitle: String, TimeAgo: String, DateCreate: String, ProjectContract: String){
        self.ComapnyName = ComapnyName
        self.CompanyLogo = CompanyLogo
        self.Desc = Desc
        self.DesignStagesID = DesignStagesID
        self.IsRead = IsRead
        self.MeetingID = MeetingID
        self.NotificationID = NotificationID
        self.NotificationTypeID = NotificationTypeID
        self.Other = Other
        self.ProjectId = ProjectId
        self.ProjectTitle = ProjectTitle
        self.TimeAgo = TimeAgo
        self.DateCreate = DateCreate
        self.ProjectContract = ProjectContract
    }
}
