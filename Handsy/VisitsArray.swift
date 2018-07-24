//
//  visitsArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/22/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class VisitsArray: NSObject, NSCoding {
    var MeetingID: String = ""
    var Title: String = ""
    var MeetingStatus: String = ""
    var Description: String = ""
    var Notes: String = ""
    var Start: String = ""
    var TimeStartMeeting: String = ""
    var ProjectBildTypeName: String = ""
    var Mobile: String = ""
    var EmpName: String = ""
    var Replay: String = ""
    var DateReply: String = ""
    var StartTime: String = ""
    var EndTime: String = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var ComapnyName: String = ""
    var Address: String = ""
    var Logo: String = ""
    var CompanyInfoID: String?
    var IsCompany: String?
    init(MeetingID: String, Title: String, MeetingStatus: String, Description: String, Notes: String, Start: String, TimeStartMeeting: String, ProjectBildTypeName: String, Mobile: String, EmpName: String, Replay: String, DateReply: String, StartTime: String, EndTime: String, LatBranch: Double, LngBranch: Double, ComapnyName: String, Address: String, Logo: String, CompanyInfoID: String, IsCompany: String) {
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
        self.Replay = Replay
        self.DateReply = DateReply
        self.StartTime = StartTime
        self.EndTime = EndTime
        self.LatBranch = LatBranch
        self.LngBranch = LngBranch
        self.ComapnyName = ComapnyName
        self.Address = Address
        self.Logo = Logo
        self.CompanyInfoID = CompanyInfoID
        self.IsCompany = IsCompany
    }
    public required init?(coder aDecoder: NSCoder) {
        self.MeetingID = aDecoder.decodeObject(forKey: "MeetingID") as! String
        self.Title = aDecoder.decodeObject(forKey: "Title") as! String
        self.MeetingStatus = aDecoder.decodeObject(forKey: "MeetingStatus") as! String
        self.Description = aDecoder.decodeObject(forKey: "Description") as! String
        self.Notes = aDecoder.decodeObject(forKey: "Notes") as! String
        self.Start = aDecoder.decodeObject(forKey: "Start") as! String
        self.TimeStartMeeting = aDecoder.decodeObject(forKey: "TimeStartMeeting") as! String
        self.ProjectBildTypeName = aDecoder.decodeObject(forKey: "ProjectBildTypeName") as! String
        self.Mobile = aDecoder.decodeObject(forKey: "Mobile") as! String
        self.EmpName = aDecoder.decodeObject(forKey: "EmpName") as! String
        self.Replay = aDecoder.decodeObject(forKey: "Replay") as! String
        self.DateReply = aDecoder.decodeObject(forKey: "DateReply") as! String
        self.StartTime = aDecoder.decodeObject(forKey: "StartTime") as! String
        self.EndTime = aDecoder.decodeObject(forKey: "EndTime") as! String
        self.LatBranch = aDecoder.decodeDouble(forKey: "LatBranch")
        self.LngBranch = aDecoder.decodeDouble(forKey: "LngBranch")
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName") as! String
        self.Address = aDecoder.decodeObject(forKey: "Address") as! String
        self.Logo = aDecoder.decodeObject(forKey: "Logo") as! String
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID") as? String
        self.IsCompany = aDecoder.decodeObject(forKey: "IsCompany") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.MeetingID, forKey: "MeetingID")
        aCoder.encode(self.Title, forKey: "Title")
        aCoder.encode(self.MeetingStatus, forKey: "MeetingStatus")
        aCoder.encode(self.Description, forKey: "Description")
        aCoder.encode(self.Notes, forKey: "Notes")
        aCoder.encode(self.Start, forKey: "Start")
        aCoder.encode(self.TimeStartMeeting, forKey: "TimeStartMeeting")
        aCoder.encode(self.ProjectBildTypeName, forKey: "ProjectBildTypeName")
        aCoder.encode(self.Mobile, forKey: "Mobile")
        aCoder.encode(self.EmpName, forKey: "EmpName")
        aCoder.encode(self.Replay, forKey: "Replay")
        aCoder.encode(self.DateReply, forKey: "DateReply")
        aCoder.encode(self.StartTime, forKey: "StartTime")
        aCoder.encode(self.EndTime, forKey: "EndTime")
        aCoder.encode(self.LatBranch, forKey: "LatBranch")
        aCoder.encode(self.LngBranch, forKey: "LngBranch")
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")
        aCoder.encode(self.Address, forKey: "Address")
        aCoder.encode(self.Logo, forKey: "Logo")
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
        aCoder.encode(self.IsCompany, forKey: "IsCompany")
    }
}

class DecodeVisitsModel: NSObject {
    var Visits = [VisitsArray]()
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
        return self.documentsDirectory + "/Visits.plist"
    }
    
    func append(_ item: VisitsArray) {
        if self.Visits.contains(item) {
            let index = self.Visits.index(of: item)
            self.Visits[index!].MeetingID += item.MeetingID
        } else {
            self.Visits.append(item)
        }
        self.saveItems()
    }
    
    func remove(at index: Int) {
        self.Visits.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.Visits = unarchiver.decodeObject(forKey: "Visits") as! [VisitsArray]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.Visits, forKey: "Visits")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.Visits.removeAll()
        self.saveItems()
    }
    
}
