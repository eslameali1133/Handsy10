//
//  GetProjectEngCustByCustID.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/2/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class GetProjectEngCustByCustID: NSObject, NSCoding {

    var BranchID: String = ""
    var BranchName: String = ""
    var CustmoerName: String = ""
    var CustomerEmail: String = ""
    var CustomerMobile: String = ""
    var CustomerNationalId: String = ""
    var DataSake: String = ""
    var DateLicence: String = ""
    var EmpImage: String = ""
    var EmpMobile: String = ""
    var EmpName: String = ""
    var GroundId: String = ""
    var IsDeleted: String = ""
    var JobName: String = ""
    var LatBranch: Double = 0.0
    var LatPrj: String = ""
    var LicenceNum: String = ""
    var LngBranch: Double = 0.0
    var LngPrj: String = ""
    var Notes: String = ""
    var PlanId: String = ""
    var ProjectBildTypeId: String = ""
    var ProjectEngComment: String = ""
    var ProjectId: String = ""
    var ProjectStatusColor: String = ""
    var ProjectStatusID: String = ""
    var ProjectStatusName: String = ""
    var ProjectTitle: String = ""
    var ProjectTypeId: String = ""
    var ProjectTypeName: String = ""
    var SakNum: String = ""
    var Space: String = ""
    var Status: String = ""
    var ZoomBranch: String = ""
    var ZoomPrj: String = ""
    var ComapnyName: String = ""
    var Address = ""
    var Logo = ""
    var ProjectBildTypeNum: String = ""
    var DateRegister: String = ""
    var CompanyInfoID = ""
    var IsCompany = ""
    var NotifiCount = 0
    var AllNotifiCount = 0
    var isSelected = false
    var ProjectLastComment: String?
    var ProjectLastTpye: String?
    var ProjectCommentOther: String?
    var LastDesignStagesID: String?
    var LastMeetingID: String?
    var FileCount: String?
    var ProjectFileCount: String?
    
    init(BranchID: String, BranchName: String, CustmoerName: String, CustomerEmail: String, CustomerMobile: String, CustomerNationalId: String, DataSake: String, DateLicence: String, EmpImage: String, EmpMobile: String, EmpName: String, GroundId: String, IsDeleted: String, JobName: String, LatBranch: Double, LatPrj: String, LicenceNum: String, LngBranch: Double, LngPrj: String, Notes: String, PlanId: String, ProjectBildTypeId: String, ProjectEngComment: String, ProjectId: String, ProjectStatusColor: String, ProjectStatusID: String, ProjectStatusName: String, ProjectTitle: String, ProjectTypeId: String, ProjectTypeName: String, SakNum: String, Space: String, Status: String, ZoomBranch: String, ZoomPrj: String, ComapnyName: String, Address: String, Logo: String, ProjectBildTypeNum: String, DateRegister: String, CompanyInfoID: String, IsCompany: String, NotifiCount: Int, ProjectLastComment: String, ProjectLastTpye: String, ProjectCommentOther: String, LastDesignStagesID: String, LastMeetingID: String, FileCount: String, ProjectFileCount: String) {
        self.BranchID = BranchID
        self.BranchName = BranchName
        self.CustmoerName = CustmoerName
        self.CustomerEmail = CustomerEmail
        self.CustomerMobile = CustomerMobile
        self.CustomerNationalId = CustomerNationalId
        self.DataSake = DataSake
        self.DateLicence = DateLicence
        self.EmpImage = EmpImage
        self.EmpMobile = EmpMobile
        self.EmpName = EmpName
        self.GroundId = GroundId
        self.IsDeleted = IsDeleted
        self.JobName = JobName
        self.LatBranch = LatBranch
        self.LatPrj = LatPrj
        self.LicenceNum = LicenceNum
        self.LngBranch = LngBranch
        self.LngPrj = LngPrj
        self.Notes = Notes
        self.PlanId = PlanId
        self.ProjectBildTypeId = ProjectBildTypeId
        self.ProjectEngComment = ProjectEngComment
        self.ProjectId = ProjectId
        self.ProjectStatusColor = ProjectStatusColor
        self.ProjectStatusID = ProjectStatusID
        self.ProjectStatusName = ProjectStatusName
        self.ProjectTitle = ProjectTitle
        self.ProjectTypeId = ProjectTypeId
        self.ProjectTypeName = ProjectTypeName
        self.SakNum = SakNum
        self.Space = Space
        self.Status = Status
        self.ZoomBranch = ZoomBranch
        self.ZoomPrj = ZoomPrj
        self.ComapnyName = ComapnyName
        self.Address = Address
        self.Logo = Logo
        self.ProjectBildTypeNum = ProjectBildTypeNum
        self.DateRegister = DateRegister
        self.CompanyInfoID = CompanyInfoID
        self.IsCompany = IsCompany
        self.NotifiCount = NotifiCount
        self.ProjectLastComment = ProjectLastComment
        self.ProjectLastTpye = ProjectLastTpye
        self.ProjectCommentOther = ProjectCommentOther
        self.LastDesignStagesID = LastDesignStagesID
        self.LastMeetingID = LastMeetingID
        self.FileCount = FileCount
        self.ProjectFileCount = ProjectFileCount
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.BranchID = aDecoder.decodeObject(forKey: "BranchID") as! String
        self.BranchName = aDecoder.decodeObject(forKey: "BranchName") as! String
        self.CustmoerName = aDecoder.decodeObject(forKey: "CustmoerName") as! String
        self.CustomerEmail = aDecoder.decodeObject(forKey: "CustomerEmail") as! String
        self.CustomerMobile = aDecoder.decodeObject(forKey: "CustomerMobile") as! String
        self.CustomerNationalId = aDecoder.decodeObject(forKey: "CustomerNationalId") as! String
        self.DataSake = aDecoder.decodeObject(forKey: "DataSake") as! String
        self.DateLicence = aDecoder.decodeObject(forKey: "DateLicence") as! String
        self.EmpImage = aDecoder.decodeObject(forKey: "EmpImage") as! String
        self.EmpMobile = aDecoder.decodeObject(forKey: "EmpMobile") as! String
        self.EmpName = aDecoder.decodeObject(forKey: "EmpName") as! String
        self.GroundId = aDecoder.decodeObject(forKey: "GroundId") as! String
        self.IsDeleted = aDecoder.decodeObject(forKey: "IsDeleted") as! String
        self.JobName = aDecoder.decodeObject(forKey: "JobName") as! String
        self.LatBranch = aDecoder.decodeDouble(forKey: "LatBranch")
        self.LatPrj = aDecoder.decodeObject(forKey: "LatPrj") as! String
        self.LicenceNum = aDecoder.decodeObject(forKey: "LicenceNum") as! String
        self.LngBranch = aDecoder.decodeDouble(forKey: "LngBranch")
        self.LngPrj = aDecoder.decodeObject(forKey: "LngPrj") as! String
        self.Notes = aDecoder.decodeObject(forKey: "Notes") as! String
        self.PlanId = aDecoder.decodeObject(forKey: "PlanId") as! String
        self.ProjectBildTypeId = aDecoder.decodeObject(forKey: "ProjectBildTypeId") as! String
        self.ProjectEngComment = aDecoder.decodeObject(forKey: "ProjectEngComment") as! String
        self.ProjectId = aDecoder.decodeObject(forKey: "ProjectId") as! String
        self.ProjectStatusColor = aDecoder.decodeObject(forKey: "ProjectStatusColor") as! String
        self.ProjectStatusID = aDecoder.decodeObject(forKey: "ProjectStatusID") as! String
        self.ProjectStatusName = aDecoder.decodeObject(forKey: "ProjectStatusName") as! String
        self.ProjectTitle = aDecoder.decodeObject(forKey: "ProjectTitle") as! String
        self.ProjectTypeId = aDecoder.decodeObject(forKey: "ProjectTypeId") as! String
        self.ProjectTypeName = aDecoder.decodeObject(forKey: "ProjectTypeName") as! String
        self.SakNum = aDecoder.decodeObject(forKey: "SakNum") as! String
        self.Space = aDecoder.decodeObject(forKey: "Space") as! String
        self.Status = aDecoder.decodeObject(forKey: "Status") as! String
        self.ZoomBranch = aDecoder.decodeObject(forKey: "ZoomBranch") as! String
        self.ZoomPrj = aDecoder.decodeObject(forKey: "ZoomPrj") as! String
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName") as! String
        self.Address = aDecoder.decodeObject(forKey: "Address") as! String
        self.Logo = aDecoder.decodeObject(forKey: "Logo") as! String
        self.ProjectBildTypeNum = aDecoder.decodeObject(forKey: "ProjectBildTypeNum") as! String
        self.DateRegister = aDecoder.decodeObject(forKey: "DateRegister") as! String
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID") as! String
        self.IsCompany = aDecoder.decodeObject(forKey: "IsCompany") as! String
        self.NotifiCount = aDecoder.decodeInteger(forKey: "NotifiCount")
        self.ProjectLastComment = aDecoder.decodeObject(forKey: "ProjectLastComment") as? String
        self.ProjectLastTpye = aDecoder.decodeObject(forKey: "ProjectLastTpye") as? String
        self.ProjectCommentOther = aDecoder.decodeObject(forKey: "ProjectCommentOther") as? String
        self.LastDesignStagesID = aDecoder.decodeObject(forKey: "LastDesignStagesID") as? String
        self.LastMeetingID = aDecoder.decodeObject(forKey: "LastMeetingID") as? String
        self.FileCount = aDecoder.decodeObject(forKey: "FileCount") as? String
        self.ProjectFileCount = aDecoder.decodeObject(forKey: "ProjectFileCount") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.BranchID, forKey: "BranchID")
        aCoder.encode(self.BranchName, forKey: "BranchName")
        aCoder.encode(self.CustmoerName, forKey: "CustmoerName")
        aCoder.encode(self.CustomerEmail, forKey: "CustomerEmail")
        aCoder.encode(self.CustomerMobile, forKey: "CustomerMobile")
        aCoder.encode(self.CustomerNationalId, forKey: "CustomerNationalId")
        aCoder.encode(self.DataSake, forKey: "DataSake")
        aCoder.encode(self.DateLicence, forKey: "DateLicence")
        aCoder.encode(self.EmpImage, forKey: "EmpImage")
        aCoder.encode(self.EmpMobile, forKey: "EmpMobile")
        aCoder.encode(self.EmpName, forKey: "EmpName")
        aCoder.encode(self.GroundId, forKey: "GroundId")
        aCoder.encode(self.IsDeleted, forKey: "IsDeleted")
        aCoder.encode(self.JobName, forKey: "JobName")
        aCoder.encode(self.LatBranch, forKey: "LatBranch")
        aCoder.encode(self.LatPrj, forKey: "LatPrj")
        aCoder.encode(self.LicenceNum, forKey: "LicenceNum")
        aCoder.encode(self.LngBranch, forKey: "LngBranch")
        aCoder.encode(self.LngPrj, forKey: "LngPrj")
        aCoder.encode(self.Notes, forKey: "Notes")
        aCoder.encode(self.PlanId, forKey: "PlanId")
        aCoder.encode(self.ProjectBildTypeId, forKey: "ProjectBildTypeId")
        aCoder.encode(self.ProjectEngComment, forKey: "ProjectEngComment")
        aCoder.encode(self.ProjectId, forKey: "ProjectId")
        aCoder.encode(self.ProjectStatusColor, forKey: "ProjectStatusColor")
        aCoder.encode(self.ProjectStatusID, forKey: "ProjectStatusID")
        aCoder.encode(self.ProjectStatusName, forKey: "ProjectStatusName")
        aCoder.encode(self.ProjectTitle, forKey: "ProjectTitle")
        aCoder.encode(self.ProjectTypeId, forKey: "ProjectTypeId")
        aCoder.encode(self.ProjectTypeName, forKey: "ProjectTypeName")
        aCoder.encode(self.SakNum, forKey: "SakNum")
        aCoder.encode(self.Space, forKey: "Space")
        aCoder.encode(self.Status, forKey: "Status")
        aCoder.encode(self.ZoomBranch, forKey: "ZoomBranch")
        aCoder.encode(self.ZoomPrj, forKey: "ZoomPrj")
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")
        aCoder.encode(self.Address, forKey: "Address")
        aCoder.encode(self.Logo, forKey: "Logo")
        aCoder.encode(self.ProjectBildTypeNum, forKey: "ProjectBildTypeNum")
        aCoder.encode(self.DateRegister, forKey: "DateRegister")
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
        aCoder.encode(self.IsCompany, forKey: "IsCompany")
        aCoder.encode(self.NotifiCount, forKey: "NotifiCount")
        aCoder.encode(self.ProjectLastComment, forKey: "ProjectLastComment")
        aCoder.encode(self.ProjectLastTpye, forKey: "ProjectLastTpye")
        aCoder.encode(self.ProjectCommentOther, forKey: "ProjectCommentOther")
        aCoder.encode(self.LastDesignStagesID, forKey: "LastDesignStagesID")
        aCoder.encode(self.LastMeetingID, forKey: "LastMeetingID")
        aCoder.encode(self.FileCount, forKey: "FileCount")
        aCoder.encode(self.ProjectFileCount, forKey: "ProjectFileCount")
    }
    
}

class projectsModel: NSObject {
    var projects = [GetProjectEngCustByCustID]()
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
        return self.documentsDirectory + "/projects.plist"
    }
    
    func append(_ item: GetProjectEngCustByCustID) {
        if self.projects.contains(item) {
            let index = self.projects.index(of: item)
            self.projects[index!].ProjectTitle += item.ProjectTitle
        } else {
            self.projects.append(item)
        }
        self.saveItems()
    }
    
    func remove(at index: Int) {
        self.projects.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.projects = unarchiver.decodeObject(forKey: "projects") as! [GetProjectEngCustByCustID]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.projects, forKey: "projects")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.projects.removeAll()
        self.saveItems()
    }
    
}
