//
//  VisitsDetialsArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/3/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class VisitsDetialsArray: NSObject, NSCoding {
    var Address: String?
    var ComapnyName: String?
    var Logo: String?
    var visitTitle: String?
    var MeetingStatus: String?
    var Description: String?
    var Notes: String?
    var Start: String?
    var TimeStartMeeting: String?
    var StartTime: String?
    var ProjectBildTypeName: String?
    var Mobile: String?
    var EmpName: String?
    var Replay: String?
    var DateReply: String?
    var EndTime: String?
    var LatBranch: Double?
    var LngBranch: Double?
    var JobName: String?
    var ClientReply: String?
    var MeetingID: String?
    var ProjectId: String?
    var CompanyInfoID: String?
    var IsCompany: String?
    var SakNum: String?
    init(Address: String, ComapnyName: String, Logo: String, visitTitle: String, MeetingStatus: String, Description: String, Notes: String, Start: String, TimeStartMeeting: String, StartTime: String, ProjectBildTypeName: String, Mobile: String, EmpName: String, Replay: String, DateReply: String, EndTime: String, LatBranch: Double, LngBranch: Double, JobName: String, ClientReply: String, MeetingID: String, ProjectId: String, CompanyInfoID: String, IsCompany: String,SakNum: String) {
        self.Address = Address
        self.ComapnyName = ComapnyName
        self.Logo = Logo
        self.visitTitle = visitTitle
        self.MeetingStatus = MeetingStatus
        self.Description = Description
        self.Notes = Notes
        self.Start = Start
        self.TimeStartMeeting = TimeStartMeeting
        self.StartTime = StartTime
        self.ProjectBildTypeName = ProjectBildTypeName
        self.Mobile = Mobile
        self.EmpName = EmpName
        self.Replay = Replay
        self.DateReply = DateReply
        self.EndTime = EndTime
        self.LatBranch = LatBranch
        self.LngBranch = LngBranch
        self.JobName = JobName
        self.ClientReply = ClientReply
        self.MeetingID = MeetingID
        self.ProjectId = ProjectId
        self.CompanyInfoID = CompanyInfoID
        self.IsCompany = IsCompany
        self.SakNum = SakNum
    }
    public required init?(coder aDecoder: NSCoder) {
        self.Address = aDecoder.decodeObject(forKey: "Address") as? String
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName") as? String
        self.Logo = aDecoder.decodeObject(forKey: "Logo") as? String
        self.visitTitle = aDecoder.decodeObject(forKey: "visitTitle") as? String
        self.MeetingStatus = aDecoder.decodeObject(forKey: "MeetingStatus") as? String
        self.Description = aDecoder.decodeObject(forKey: "Description") as? String
        self.Notes = aDecoder.decodeObject(forKey: "Notes") as? String
        self.Start = aDecoder.decodeObject(forKey: "Start") as? String
        self.TimeStartMeeting = aDecoder.decodeObject(forKey: "TimeStartMeeting") as? String
        self.StartTime = aDecoder.decodeObject(forKey: "StartTime") as? String
        self.ProjectBildTypeName = aDecoder.decodeObject(forKey: "ProjectBildTypeName") as? String
        self.Mobile = aDecoder.decodeObject(forKey: "Mobile") as? String
        self.EmpName = aDecoder.decodeObject(forKey: "EmpName") as? String
        self.Replay = aDecoder.decodeObject(forKey: "Replay") as? String
        self.DateReply = aDecoder.decodeObject(forKey: "DateReply") as? String
        self.EndTime = aDecoder.decodeObject(forKey: "EndTime") as? String
        self.LatBranch = aDecoder.decodeObject(forKey: "LatBranch") as? Double
        self.LngBranch = aDecoder.decodeObject(forKey: "LngBranch") as? Double
        self.JobName = aDecoder.decodeObject(forKey: "JobName") as? String
        self.ClientReply = aDecoder.decodeObject(forKey: "ClientReply") as? String
        self.MeetingID = aDecoder.decodeObject(forKey: "MeetingID") as? String
        self.ProjectId = aDecoder.decodeObject(forKey: "ProjectId") as? String
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID") as? String
        self.IsCompany = aDecoder.decodeObject(forKey: "IsCompany") as? String
         self.SakNum = aDecoder.decodeObject(forKey: "SakNum") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.Address, forKey: "Address")
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")
        aCoder.encode(self.Logo, forKey: "Logo")
        aCoder.encode(self.visitTitle, forKey: "visitTitle")
        aCoder.encode(self.MeetingStatus, forKey: "MeetingStatus")
        aCoder.encode(self.Description, forKey: "Description")
        aCoder.encode(self.Notes, forKey: "Notes")
        aCoder.encode(self.Start, forKey: "Start")
        aCoder.encode(self.TimeStartMeeting, forKey: "TimeStartMeeting")
        aCoder.encode(self.StartTime, forKey: "StartTime")
        aCoder.encode(self.ProjectBildTypeName, forKey: "ProjectBildTypeName")
        aCoder.encode(self.Mobile, forKey: "Mobile")
        aCoder.encode(self.EmpName, forKey: "EmpName")
        aCoder.encode(self.Replay, forKey: "Replay")
        aCoder.encode(self.DateReply, forKey: "DateReply")
        aCoder.encode(self.EndTime, forKey: "EndTime")
        aCoder.encode(self.LatBranch, forKey: "LatBranch")
        aCoder.encode(self.LngBranch, forKey: "LngBranch")
        aCoder.encode(self.JobName, forKey: "JobName")
        aCoder.encode(self.ClientReply, forKey: "ClientReply")
        aCoder.encode(self.MeetingID, forKey: "MeetingID")
        aCoder.encode(self.ProjectId, forKey: "ProjectId")
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
        aCoder.encode(self.IsCompany, forKey: "IsCompany")
       aCoder.encode(self.SakNum, forKey: "SakNum")
    }
}

class VisitsDetialsModel : NSObject {
    
    var visitsDetialsArray = [VisitsDetialsArray]()
    
    override init() {
        super.init()
        self.loadItems()
    }
    
    deinit {
        self.saveItems()
    }
    
    var documentsDirectory : String {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
    }
    
    var itemsPath : String {
        return self.documentsDirectory + "/visitsDetials.plist"
    }
    
    func append(_ item: VisitsDetialsArray) {
        if visitsDetialsArray.contains(where: {$0.MeetingID == item.MeetingID}) {
            print("ite: \(item)")
            //            let index = self.projectDetialsArray.index(of: item)
            //            self.projectDetialsArray.remove(at: index!)
            //            print("todo: \(self.projectDetialsArray)")
            //            self.projectDetialsArray.insert(item, at: index!)
            //            print("todo2: \(self.projectDetialsArray)")
        }else {
            self.visitsDetialsArray.append(item)
            self.saveItems()
        }
    }
    
    func returnProjectDetials(at meetingID: String) -> VisitsDetialsArray? {
    
        return visitsDetialsArray.filter({ $0.MeetingID == MeetingID}).first!
    }
    
    func remove(at index: Int) {
        self.visitsDetialsArray.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.visitsDetialsArray = unarchiver.decodeObject(forKey: "visitsDetials") as! [VisitsDetialsArray]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.visitsDetialsArray, forKey: "visitsDetials")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.visitsDetialsArray.removeAll()
        self.saveItems()
    }
    
}
