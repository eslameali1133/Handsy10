//
//  DesignsDetialsArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/3/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class DesignsDetialsArray: NSObject, NSCoding {
    var CreateDate: String?
    var DesignFile: String?
    var DesignStagesID: String?
    var Details: String?
    var EmpName: String?
    var mobileStr: String?
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
    var JobName: String?
    var Address: String?
    var Logo: String?
    var ProjectId: String?
    var CompanyInfoID: String?
    var IsCompany: String?
    init(CreateDate: String, DesignFile: String, DesignStagesID: String, Details: String, EmpName: String, mobileStr: String, ProjectBildTypeName: String, ProjectStatusID: String, SakNum: String, StagesDetailsName: String, Status: String, ClientReply: String, EmpReply: String, ComapnyName: String, LatBranch: Double, LngBranch: Double, JobName: String, Address: String, Logo: String, ProjectId: String, CompanyInfoID: String, IsCompany: String) {
        self.CreateDate = CreateDate
        self.DesignFile = DesignFile
        self.DesignStagesID = DesignStagesID
        self.Details = Details
        self.EmpName = EmpName
        self.mobileStr = mobileStr
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
        self.JobName = JobName
        self.Address = Address
        self.Logo = Logo
        self.ProjectId = ProjectId
        self.CompanyInfoID = CompanyInfoID
        self.IsCompany = IsCompany
    }
    public required init?(coder aDecoder: NSCoder) {
        self.CreateDate = aDecoder.decodeObject(forKey: "CreateDate") as? String
        self.DesignFile = aDecoder.decodeObject(forKey: "DesignFile") as? String
        self.DesignStagesID = aDecoder.decodeObject(forKey: "DesignStagesID") as? String
        self.Details = aDecoder.decodeObject(forKey: "Details") as? String
        self.EmpName = aDecoder.decodeObject(forKey: "EmpName") as? String
        self.mobileStr = aDecoder.decodeObject(forKey: "mobileStr") as? String
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
        self.JobName = aDecoder.decodeObject(forKey: "JobName") as? String
        self.Address = aDecoder.decodeObject(forKey: "Address") as? String
        self.Logo = aDecoder.decodeObject(forKey: "Logo") as? String
        self.ProjectId = aDecoder.decodeObject(forKey: "ProjectId") as? String
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID") as? String
        self.IsCompany = aDecoder.decodeObject(forKey: "IsCompany") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.CreateDate, forKey: "CreateDate")
        aCoder.encode(self.DesignFile, forKey: "DesignFile")
        aCoder.encode(self.DesignStagesID, forKey: "DesignStagesID")
        aCoder.encode(self.Details, forKey: "Details")
        aCoder.encode(self.EmpName, forKey: "EmpName")
        aCoder.encode(self.mobileStr, forKey: "mobileStr")
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
        aCoder.encode(self.JobName, forKey: "JobName")
        aCoder.encode(self.Address, forKey: "Address")
        aCoder.encode(self.Logo, forKey: "Logo")
        aCoder.encode(self.ProjectId, forKey: "ProjectId")
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
        aCoder.encode(self.IsCompany, forKey: "IsCompany")
    }
}
class DesignsDetialsModel : NSObject {
    
    var designsDetialsArray = [DesignsDetialsArray]()
    
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
        return self.documentsDirectory + "/designsDetials.plist"
    }
    
    func append(_ item: DesignsDetialsArray) {
        if designsDetialsArray.contains(where: {$0.DesignStagesID == item.DesignStagesID}) {
            print("ite: \(item)")
            //            let index = self.projectDetialsArray.index(of: item)
            //            self.projectDetialsArray.remove(at: index!)
            //            print("todo: \(self.projectDetialsArray)")
            //            self.projectDetialsArray.insert(item, at: index!)
            //            print("todo2: \(self.projectDetialsArray)")
        }else {
            self.designsDetialsArray.append(item)
            self.saveItems()
        }
    }
    
    func returnProjectDetials(at designStagesID: String) -> DesignsDetialsArray? {
        return designsDetialsArray.filter({ $0.DesignStagesID == designStagesID}).first!
    }
    
    func remove(at index: Int) {
        self.designsDetialsArray.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.designsDetialsArray = unarchiver.decodeObject(forKey: "designsDetials") as! [DesignsDetialsArray]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.designsDetialsArray, forKey: "designsDetials")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.designsDetialsArray.removeAll()
        self.saveItems()
    }
    
}
