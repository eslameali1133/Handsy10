//
//  DesignByProjectIdArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 1/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class DesignByProjectIdArray: NSObject, NSCoding {
    var CreateDate: String?
    var DesignFile: String?
    var DesignStagesID: String?
    var Details: String?
    var EmpName: String?
    var Mobile: String?
    var ProjectBildTypeName: String?
    var ProjectStatusID: String?
    var SakNum: String?
    var StagesDetailsName: String?
    var Status: String?
    var ClientReply: String?
    var EmpReply: String?
    var ComapnyName: String?
    var LatBranch: Double?
    var LngBranch: Double?
    var Address: String?
    var Logo: String?
    init(CreateDate: String, DesignFile: String, DesignStagesID: String, Details: String, EmpName: String, Mobile: String, ProjectBildTypeName: String, ProjectStatusID: String, SakNum: String, StagesDetailsName: String, Status: String, ClientReply: String, EmpReply: String, ComapnyName: String, LatBranch: Double, LngBranch: Double, Address: String, Logo: String) {
        self.CreateDate = CreateDate
        self.DesignFile = DesignFile
        self.DesignStagesID = DesignStagesID
        self.Details = Details
        self.EmpName = EmpName
        self.Mobile = Mobile
        self.ProjectBildTypeName = ProjectBildTypeName
        self.ProjectStatusID = ProjectStatusID
        self.SakNum = SakNum
        self.StagesDetailsName = StagesDetailsName
        self.Status = Status
        self.ClientReply = ClientReply
        self.EmpReply = EmpReply
        self.ComapnyName = ComapnyName
        self.LatBranch = LatBranch
        self.LngBranch = LngBranch
        self.Address = Address
        self.Logo = Logo
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.CreateDate = aDecoder.decodeObject(forKey: "CreateDate") as? String
        self.DesignFile = aDecoder.decodeObject(forKey: "DesignFile") as? String
        self.DesignStagesID = aDecoder.decodeObject(forKey: "DesignStagesID") as? String
        self.Details = aDecoder.decodeObject(forKey: "Details") as? String
        self.EmpName = aDecoder.decodeObject(forKey: "EmpName") as? String
        self.Mobile = aDecoder.decodeObject(forKey: "Mobile") as? String
        self.ProjectBildTypeName = aDecoder.decodeObject(forKey: "ProjectBildTypeName") as? String
        self.ProjectStatusID = aDecoder.decodeObject(forKey: "ProjectStatusID") as? String
        self.SakNum = aDecoder.decodeObject(forKey: "SakNum") as? String
        self.StagesDetailsName = aDecoder.decodeObject(forKey: "StagesDetailsName") as? String
        self.Status = aDecoder.decodeObject(forKey: "Status") as? String
        self.ClientReply = aDecoder.decodeObject(forKey: "ClientReply") as? String
        self.EmpReply = aDecoder.decodeObject(forKey: "EmpReply") as? String
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName") as? String
        self.LatBranch = aDecoder.decodeObject(forKey: "LatBranch") as? Double
        self.LngBranch = aDecoder.decodeObject(forKey: "LngBranch") as? Double
        self.Address = aDecoder.decodeObject(forKey: "Address") as? String
        self.Logo = aDecoder.decodeObject(forKey: "Logo") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.CreateDate, forKey: "CreateDate")
        aCoder.encode(self.DesignFile, forKey: "DesignFile")
        aCoder.encode(self.DesignStagesID, forKey: "DesignStagesID")
        aCoder.encode(self.Details, forKey: "Details")
        aCoder.encode(self.EmpName, forKey: "EmpName")
        aCoder.encode(self.Mobile, forKey: "Mobile")
        aCoder.encode(self.ProjectBildTypeName, forKey: "ProjectBildTypeName")
        aCoder.encode(self.ProjectStatusID, forKey: "ProjectStatusID")
        aCoder.encode(self.SakNum, forKey: "SakNum")
        aCoder.encode(self.StagesDetailsName, forKey: "StagesDetailsName")
        aCoder.encode(self.Status, forKey: "Status")
        aCoder.encode(self.ClientReply, forKey: "ClientReply")
        aCoder.encode(self.EmpReply, forKey: "EmpReply")
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")
        aCoder.encode(self.LatBranch, forKey: "LatBranch")
        aCoder.encode(self.LngBranch, forKey: "LngBranch")
        aCoder.encode(self.Address, forKey: "Address")
        aCoder.encode(self.Logo, forKey: "Logo")
    }
}

class DesignProjectIdModel: NSObject {
    
    var dicDesignByProjectId = [String: [DesignByProjectIdArray]]()
    
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
        return self.documentsDirectory + "/DesignByProjectId.plist"
    }
    
    func append(_ item: [DesignByProjectIdArray], index: String) {
        dicDesignByProjectId[index] = item
        self.saveItems()
    }
    
    func returnProjectDetials(at projectId: String) -> [DesignByProjectIdArray]? {
        return dicDesignByProjectId[projectId]
    }
    
    //    func remove(at index: Int) {
    //        self.arrayServiceOfCompany.remove(at: index)
    //        self.saveItems()
    //    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.dicDesignByProjectId = unarchiver.decodeObject(forKey: "DesignByProjectId") as! [String: [DesignByProjectIdArray]]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.dicDesignByProjectId, forKey: "DesignByProjectId")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.dicDesignByProjectId.removeAll()
        self.saveItems()
    }
    
}
