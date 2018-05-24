//
//  VisitsByProjectIdArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class VisitsByProjectIdArray: NSObject, NSCoding {
    var MeetingID: String?
    var Title: String?
    var MeetingStatus: String?
    var Description: String?
    var Notes: String?
    var Start: String?
    var TimeStartMeeting: String?
    var ProjectBildTypeName: String?
    var Mobile: String?
    var EmpName: String?
    var JobName: String?
    var Replay: String?
    var DateReply: String?
    var StartTime: String?
    var EndTime: String?
    var ComapnyName: String?
    var LatBranch: Double?
    var LngBranch: Double?
    var Address: String?
    var Logo: String?
    init(MeetingID: String, Title: String, MeetingStatus: String, Description: String, Notes: String, Start: String, TimeStartMeeting: String, ProjectBildTypeName: String, Mobile: String, EmpName: String, JobName: String, Replay: String, DateReply: String, StartTime: String, EndTime: String, ComapnyName: String, LatBranch: Double, LngBranch: Double, Address: String, Logo: String) {
        self.MeetingID = MeetingID
        self.Title = Title
        self.MeetingStatus = MeetingStatus
        self.Description = Description
        self.Notes = Notes
        self.Start = Start
        self.TimeStartMeeting = TimeStartMeeting
        self.ProjectBildTypeName = ProjectBildTypeName
        self.Mobile = Mobile
        self.EmpName = EmpName
        self.JobName = JobName
        self.Replay = Replay
        self.DateReply = DateReply
        self.StartTime = StartTime
        self.EndTime = EndTime
        self.ComapnyName = ComapnyName
        self.LatBranch = LatBranch
        self.LngBranch = LngBranch
        self.Address = Address
        self.Logo = Logo
    }
    public required init?(coder aDecoder: NSCoder) {
        self.MeetingID = aDecoder.decodeObject(forKey: "MeetingID") as? String
        self.Title = aDecoder.decodeObject(forKey: "Title") as? String
        self.Start = aDecoder.decodeObject(forKey: "Start") as? String
        self.Notes = aDecoder.decodeObject(forKey: "Notes") as? String
        self.Mobile = aDecoder.decodeObject(forKey: "Mobile") as? String
        self.ProjectBildTypeName = aDecoder.decodeObject(forKey: "TimeStartMeeting") as? String
        self.TimeStartMeeting = aDecoder.decodeObject(forKey: "ProjectBildTypeName") as? String
        self.MeetingStatus = aDecoder.decodeObject(forKey: "MeetingStatus") as? String
        self.Description = aDecoder.decodeObject(forKey: "Description") as? String
        self.EmpName = aDecoder.decodeObject(forKey: "EmpName") as? String
        self.JobName = aDecoder.decodeObject(forKey: "JobName") as? String
        self.Replay = aDecoder.decodeObject(forKey: "Replay") as? String
        self.DateReply = aDecoder.decodeObject(forKey: "DateReply") as? String
        self.StartTime = aDecoder.decodeObject(forKey: "StartTime") as? String
        self.EndTime = aDecoder.decodeObject(forKey: "EndTime") as? String
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName") as? String
        self.LatBranch = aDecoder.decodeObject(forKey: "LatBranch") as? Double
        self.LngBranch = aDecoder.decodeObject(forKey: "LngBranch") as? Double
        self.Address = aDecoder.decodeObject(forKey: "Address") as? String
        self.Logo = aDecoder.decodeObject(forKey: "Logo") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.MeetingID, forKey: "MeetingID")
        aCoder.encode(self.Title, forKey: "Title")
        aCoder.encode(self.MeetingStatus, forKey: "MeetingStatus")
        aCoder.encode(self.Start, forKey: "Start")
        aCoder.encode(self.Notes, forKey: "Notes")
        aCoder.encode(self.Mobile, forKey: "Mobile")
        aCoder.encode(self.ProjectBildTypeName, forKey: "ProjectBildTypeName")
        aCoder.encode(self.TimeStartMeeting, forKey: "TimeStartMeeting")
        aCoder.encode(self.EndTime, forKey: "EndTime")
        aCoder.encode(self.Description, forKey: "Description")
        aCoder.encode(self.EmpName, forKey: "EmpName")
        aCoder.encode(self.JobName, forKey: "JobName")
        aCoder.encode(self.Replay, forKey: "Replay")
        aCoder.encode(self.DateReply, forKey: "DateReply")
        aCoder.encode(self.StartTime, forKey: "StartTime")
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")
        aCoder.encode(self.LatBranch, forKey: "LatBranch")
        aCoder.encode(self.LngBranch, forKey: "LngBranch")
        aCoder.encode(self.Address, forKey: "Address")
        aCoder.encode(self.Logo, forKey: "Logo")
    }
}

class VisitsProjectIdModel: NSObject {
    var dicVisitsProjectId = [String: [VisitsByProjectIdArray]]()
    
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
        return self.documentsDirectory + "/VisitsProjectId.plist"
    }
    
    func append(_ item: [VisitsByProjectIdArray], index: String) {
        dicVisitsProjectId[index] = item
        self.saveItems()
    }
    
    func returnProjectDetials(at projectId: String) -> [VisitsByProjectIdArray]? {
        return dicVisitsProjectId[projectId]
    }
    
    //    func remove(at index: Int) {
    //        self.arrayServiceOfCompany.remove(at: index)
    //        self.saveItems()
    //    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.dicVisitsProjectId = unarchiver.decodeObject(forKey: "VisitsProjectId") as! [String: [VisitsByProjectIdArray]]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.dicVisitsProjectId, forKey: "VisitsProjectId")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.dicVisitsProjectId.removeAll()
        self.saveItems()
    }
    
}

class ArcVisitsProjectIdModel: NSObject {
    var dicVisitsProjectId = [String: [VisitsByProjectIdArray]]()
    
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
        return self.documentsDirectory + "/ArcVisitsProjectId.plist"
    }
    
    func append(_ item: [VisitsByProjectIdArray], index: String) {
        dicVisitsProjectId[index] = item
        self.saveItems()
    }
    
    func returnProjectDetials(at projectId: String) -> [VisitsByProjectIdArray]? {
        return dicVisitsProjectId[projectId]
    }
    
    //    func remove(at index: Int) {
    //        self.arrayServiceOfCompany.remove(at: index)
    //        self.saveItems()
    //    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.dicVisitsProjectId = unarchiver.decodeObject(forKey: "ArcVisitsProjectId") as! [String: [VisitsByProjectIdArray]]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.dicVisitsProjectId, forKey: "ArcVisitsProjectId")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.dicVisitsProjectId.removeAll()
        self.saveItems()
    }
    
}

