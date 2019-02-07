//
//  ProjectDetialsArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 2/26/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ProjectDetialsArray: NSObject, NSCoding {
    var ProjectId: String?
    var ProjectsPaymentsCost: String?
    var CountNotPaid: String?
    var CountPaid: String?
    var EmpImage: String?
    var BranchID: String?
    var BranchName: String?
    var CustmoerName: String?
    var CustomerEmail: String?
    var CustomerMobile: String?
    var CustomerNationalId: String?
    var DataSake: String?
    var DateLicence: String?
    var EmpMobile: String?
    var EmpName: String?
    var GroundId: String?
    var IsDeleted: String?
    var JobName: String?
    var LatBranch: Double = 0.0
    var LatPrj: String?
    var LicenceNum: String?
    var LngBranch: Double = 0.0
    var LngPrj: String?
    var Notes: String?
    var PlanId: String?
    var ProjectInvoice: String?
    var ProjectContract: String?
    var ProjectStatusNum: String?
    var ProjectBildTypeId: String?
    var ProjectEngComment: String?
    var ProjectStatusColor: String?
    var ProjectStatusID: String?
    var ProjectStatusName: String?
    var ProjectTitle: String?
    var ProjectTypeId: String?
    var ProjectTypeName: String?
    var SakNum: String?
    var Space: String?
    var Status: String?
    var TotalNotPaid: String?
    var TotalPaid: String?
    var ZoomBranch: String?
    var ZoomPrj: String?
    var projectOrderContractPhotoPath: String?
    var ProvincesName: String?
    var SectoinName: String?
    var ProjectsOrdersCellarErea: String?
    var ProjectsOrdersReFloorErea: String?
    var ProjectsOrdersSupplementErea: String?
    var ProjectsOrdersSupplementExternalErea: String?
    var ProjectsOrdersFloorErea: String?
    var ProjectsOrdersLandErea: String?
    var ProjectsOrdersFloorNummber: String?
    var ProjectsOrdersTotalBildErea: String?
    var ProjectsPaymentsWork: String?
    var ProjectsPaymentsDiscount: String?
    var CompanyInfoID: String?
    var ComapnyName: String?
    var CompanyAddress: String?
    var Logo: String?
    var isCompany: String?
    var DesignNewCount: String?
    var DesignCount: String?
    var Meetingcount: String?
    var MeetingDate: String?
    var MeetingTime: String?
    var ProjectLastComment: String?
    var ProjectLastTpye: String?
    var ProjectCommentOther: String?
    var LastDesignStagesID: String?
    var LastMeetingID: String?
    var MeetingNotifiCount: String?
    var DesignNotifiCount: String?
    var NotifiCount: Int?
    var FileCount: String?
    var ProjectFileCount: String?
    var DocCount:String?
    
    init(ProjectId: String, ProjectsPaymentsCost: String, CountNotPaid: String, CountPaid: String, EmpImage: String, BranchID: String, BranchName: String, CustmoerName: String, CustomerEmail: String, CustomerMobile: String, CustomerNationalId: String, DataSake: String, DateLicence: String, EmpMobile: String, EmpName: String, GroundId: String, IsDeleted: String, JobName: String, LatBranch: Double, LatPrj: String, LicenceNum: String, LngBranch: Double, LngPrj: String, Notes: String, PlanId: String, ProjectInvoice: String, ProjectContract: String, ProjectStatusNum: String, ProjectBildTypeId: String, ProjectEngComment: String, ProjectStatusColor: String, ProjectStatusID: String, ProjectStatusName: String, ProjectTitle: String, ProjectTypeId: String, ProjectTypeName: String, SakNum: String, Space: String, Status: String, TotalNotPaid: String, TotalPaid: String, ZoomBranch: String, ZoomPrj: String, projectOrderContractPhotoPath: String, ProvincesName: String, SectoinName: String, ProjectsOrdersCellarErea: String, ProjectsOrdersReFloorErea: String, ProjectsOrdersSupplementErea: String, ProjectsOrdersSupplementExternalErea: String, ProjectsOrdersFloorErea: String, ProjectsOrdersLandErea: String, ProjectsOrdersFloorNummber: String, ProjectsOrdersTotalBildErea: String, ProjectsPaymentsWork: String, ProjectsPaymentsDiscount: String, CompanyInfoID: String, ComapnyName: String, CompanyAddress: String, Logo: String, isCompany: String, DesignNewCount: String, DesignCount: String, Meetingcount: String, MeetingDate: String, MeetingTime: String, ProjectLastComment: String, ProjectLastTpye: String, ProjectCommentOther: String, LastDesignStagesID: String, LastMeetingID: String, MeetingNotifiCount: String, DesignNotifiCount: String, NotifiCount: Int, FileCount: String, ProjectFileCount: String,DocCount: String) {
        self.ProjectId = ProjectId
        self.ProjectsPaymentsCost = ProjectsPaymentsCost
        self.CountNotPaid = CountNotPaid
        self.CountPaid = CountPaid
        self.EmpImage = EmpImage
        self.BranchID = BranchID
        self.BranchName = BranchName
        self.CustmoerName = CustmoerName
        self.CustomerEmail = CustomerEmail
        self.CustomerMobile = CustomerMobile
        self.CustomerNationalId = CustomerNationalId
        self.DataSake = DataSake
        self.DateLicence = DateLicence
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
        self.ProjectInvoice = ProjectInvoice
        self.ProjectContract = ProjectContract
        self.ProjectStatusNum = ProjectStatusNum
        self.ProjectBildTypeId = ProjectBildTypeId
        self.ProjectEngComment = ProjectEngComment
        self.ProjectStatusColor = ProjectStatusColor
        self.ProjectStatusID = ProjectStatusID
        self.ProjectStatusName = ProjectStatusName
        self.ProjectTitle = ProjectTitle
        self.ProjectTypeId = ProjectTypeId
        self.ProjectTypeName = ProjectTypeName
        self.SakNum = SakNum
        self.Space = Space
        self.Status = Status
        self.TotalNotPaid = TotalNotPaid
        self.TotalPaid = TotalPaid
        self.ZoomBranch = ZoomBranch
        self.ZoomPrj = ZoomPrj
        self.projectOrderContractPhotoPath = projectOrderContractPhotoPath
        self.ProvincesName = ProvincesName
        self.SectoinName = SectoinName
        self.ProjectsOrdersCellarErea = ProjectsOrdersCellarErea
        self.ProjectsOrdersReFloorErea = ProjectsOrdersReFloorErea
        self.ProjectsOrdersSupplementErea = ProjectsOrdersSupplementErea
        self.ProjectsOrdersSupplementExternalErea = ProjectsOrdersSupplementExternalErea
        self.ProjectsOrdersFloorErea = ProjectsOrdersFloorErea
        self.ProjectsOrdersLandErea = ProjectsOrdersLandErea
        self.ProjectsOrdersFloorNummber = ProjectsOrdersFloorNummber
        self.ProjectsOrdersTotalBildErea = ProjectsOrdersTotalBildErea
        self.ProjectsPaymentsWork = ProjectsPaymentsWork
        self.ProjectsPaymentsDiscount = ProjectsPaymentsDiscount
        self.CompanyInfoID = CompanyInfoID
        self.ComapnyName = ComapnyName
        self.CompanyAddress = CompanyAddress
        self.Logo = Logo
        self.isCompany = isCompany
        self.DesignNewCount = DesignNewCount
        self.DesignCount = DesignCount
        self.Meetingcount = Meetingcount
        self.MeetingDate = MeetingDate
        self.MeetingTime = MeetingTime
        self.ProjectLastComment = ProjectLastComment
        self.ProjectLastTpye = ProjectLastTpye
        self.ProjectCommentOther = ProjectCommentOther
        self.LastDesignStagesID = LastDesignStagesID
        self.LastMeetingID = LastMeetingID
        self.MeetingNotifiCount = MeetingNotifiCount
        self.DesignNotifiCount = DesignNotifiCount
        self.NotifiCount = NotifiCount
        self.FileCount = FileCount
        self.ProjectFileCount = ProjectFileCount
        self.DocCount = DocCount
    }
    
        public required init?(coder aDecoder: NSCoder) {
            self.ProjectId = aDecoder.decodeObject(forKey: "ProjectId")  as? String
        self.ProjectsPaymentsCost = aDecoder.decodeObject(forKey: "ProjectsPaymentsCost")  as? String
        self.CountNotPaid = aDecoder.decodeObject(forKey: "CountNotPaid")  as? String
        self.CountPaid = aDecoder.decodeObject(forKey: "CountPaid")  as? String
        self.EmpImage = aDecoder.decodeObject(forKey: "EmpImage")  as? String
        self.BranchID = aDecoder.decodeObject(forKey: "BranchID")  as? String
        self.BranchName = aDecoder.decodeObject(forKey: "BranchName")  as? String
        self.CustmoerName = aDecoder.decodeObject(forKey: "CustmoerName")  as? String
        self.CustomerEmail = aDecoder.decodeObject(forKey: "CustomerEmail")  as? String
        self.CustomerMobile = aDecoder.decodeObject(forKey: "CustomerMobile")  as? String
        self.CustomerNationalId = aDecoder.decodeObject(forKey: "CustomerNationalId")  as? String
        self.DataSake = aDecoder.decodeObject(forKey: "DataSake")  as? String
        self.DateLicence = aDecoder.decodeObject(forKey: "DateLicence")  as? String
        self.EmpMobile = aDecoder.decodeObject(forKey: "EmpMobile")  as? String
        self.EmpName = aDecoder.decodeObject(forKey: "EmpName")  as? String
        self.GroundId = aDecoder.decodeObject(forKey: "GroundId")  as? String
        self.IsDeleted = aDecoder.decodeObject(forKey: "IsDeleted")  as? String
        self.JobName = aDecoder.decodeObject(forKey: "JobName")  as? String
        self.LatBranch = aDecoder.decodeDouble(forKey: "LatBranch")
        self.LatPrj = aDecoder.decodeObject(forKey: "LatPrj")  as? String
        self.LicenceNum = aDecoder.decodeObject(forKey: "LicenceNum")  as? String
        self.LngBranch = aDecoder.decodeDouble(forKey: "LngBranch")
        self.LngPrj = aDecoder.decodeObject(forKey: "LngPrj")  as? String
        self.Notes = aDecoder.decodeObject(forKey: "Notes")  as? String
        self.PlanId = aDecoder.decodeObject(forKey: "PlanId")  as? String
        self.ProjectInvoice = aDecoder.decodeObject(forKey: "ProjectInvoice")  as? String
        self.ProjectContract = aDecoder.decodeObject(forKey: "ProjectContract")  as? String
        self.ProjectStatusNum = aDecoder.decodeObject(forKey: "ProjectStatusNum")  as? String
        self.ProjectBildTypeId = aDecoder.decodeObject(forKey: "ProjectBildTypeId")  as? String
        self.ProjectEngComment = aDecoder.decodeObject(forKey: "ProjectEngComment")  as? String
        self.ProjectStatusColor = aDecoder.decodeObject(forKey: "ProjectStatusColor")  as? String
        self.ProjectStatusID = aDecoder.decodeObject(forKey: "ProjectStatusID")  as? String
        self.ProjectStatusName = aDecoder.decodeObject(forKey: "ProjectStatusName")  as? String
        self.ProjectTitle = aDecoder.decodeObject(forKey: "ProjectTitle")  as? String
        self.ProjectTypeId = aDecoder.decodeObject(forKey: "ProjectTypeId")  as? String
        self.ProjectTypeName = aDecoder.decodeObject(forKey: "ProjectTypeName")  as? String
        self.SakNum = aDecoder.decodeObject(forKey: "SakNum")  as? String
        self.Space = aDecoder.decodeObject(forKey: "Space")  as? String
        self.Status = aDecoder.decodeObject(forKey: "Status") as? String
        self.TotalNotPaid = aDecoder.decodeObject(forKey: "TotalNotPaid")  as? String
        self.TotalPaid = aDecoder.decodeObject(forKey: "TotalPaid")  as? String
        self.ZoomBranch = aDecoder.decodeObject(forKey: "ZoomBranch")  as? String
        self.ZoomPrj = aDecoder.decodeObject(forKey: "ZoomPrj")  as? String
        self.projectOrderContractPhotoPath = aDecoder.decodeObject(forKey: "projectOrderContractPhotoPath")  as? String
        self.ProvincesName = aDecoder.decodeObject(forKey: "ProvincesName")  as? String
        self.SectoinName = aDecoder.decodeObject(forKey: "SectoinName")  as? String
        self.ProjectsOrdersCellarErea = aDecoder.decodeObject(forKey: "ProjectsOrdersCellarErea")  as? String
        self.ProjectsOrdersReFloorErea = aDecoder.decodeObject(forKey: "ProjectsOrdersReFloorErea")  as? String
        self.ProjectsOrdersSupplementErea = aDecoder.decodeObject(forKey: "ProjectsOrdersSupplementErea")  as? String
        self.ProjectsOrdersSupplementExternalErea = aDecoder.decodeObject(forKey: "ProjectsOrdersSupplementExternalErea")  as? String
        self.ProjectsOrdersFloorErea = aDecoder.decodeObject(forKey: "ProjectsOrdersFloorErea")  as? String
        self.ProjectsOrdersLandErea = aDecoder.decodeObject(forKey: "ProjectsOrdersLandErea")  as? String
        self.ProjectsOrdersFloorNummber = aDecoder.decodeObject(forKey: "ProjectsOrdersFloorNummber")  as? String
        self.ProjectsOrdersTotalBildErea = aDecoder.decodeObject(forKey: "ProjectsOrdersTotalBildErea")  as? String
        self.ProjectsPaymentsWork = aDecoder.decodeObject(forKey: "ProjectsPaymentsWork")  as? String
        self.ProjectsPaymentsDiscount = aDecoder.decodeObject(forKey: "ProjectsPaymentsDiscount")  as? String
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID")  as? String
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName")  as? String
        self.CompanyAddress = aDecoder.decodeObject(forKey: "CompanyAddress")  as? String
        self.Logo = aDecoder.decodeObject(forKey: "Logo")  as? String
        self.isCompany = aDecoder.decodeObject(forKey: "isCompany")  as? String
        self.DesignNewCount = aDecoder.decodeObject(forKey: "DesignNewCount")  as? String
        self.DesignCount = aDecoder.decodeObject(forKey: "DesignCount")  as? String
        self.MeetingDate = aDecoder.decodeObject(forKey: "MeetingDate")  as? String
        self.MeetingTime = aDecoder.decodeObject(forKey: "MeetingTime")  as? String
        self.ProjectLastComment = aDecoder.decodeObject(forKey: "ProjectLastComment")  as? String
        self.ProjectLastTpye = aDecoder.decodeObject(forKey: "ProjectLastTpye")  as? String
        self.ProjectCommentOther = aDecoder.decodeObject(forKey: "ProjectCommentOther")  as? String
        self.LastDesignStagesID = aDecoder.decodeObject(forKey: "LastDesignStagesID")  as? String
        self.LastMeetingID = aDecoder.decodeObject(forKey: "LastMeetingID")  as? String
        self.MeetingNotifiCount = aDecoder.decodeObject(forKey: "MeetingNotifiCount")  as? String
        self.DesignNotifiCount = aDecoder.decodeObject(forKey: "DesignNotifiCount")  as? String
        self.NotifiCount = aDecoder.decodeObject(forKey: "NotifiCount")  as? Int
        self.Meetingcount = aDecoder.decodeObject(forKey: "Meetingcount") as? String
        self.FileCount = aDecoder.decodeObject(forKey: "FileCount") as? String
        self.ProjectFileCount = aDecoder.decodeObject(forKey: "ProjectFileCount") as? String
            self.DocCount =  aDecoder.decodeObject(forKey: "DocCount") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.ProjectId, forKey: "ProjectId")
        aCoder.encode(self.ProjectsPaymentsCost, forKey: "ProjectsPaymentsCost")
        aCoder.encode(self.CountNotPaid, forKey: "CountNotPaid")
        aCoder.encode(self.CountPaid, forKey: "CountPaid")
        aCoder.encode(self.EmpImage, forKey: "EmpImage")
        aCoder.encode(self.BranchID, forKey: "BranchID")
        aCoder.encode(self.BranchName, forKey: "BranchName")
        aCoder.encode(self.CustmoerName, forKey: "CustmoerName")
        aCoder.encode(self.CustomerEmail, forKey: "CustomerEmail")
        aCoder.encode(self.CustomerMobile, forKey: "CustomerMobile")
        aCoder.encode(self.CustomerNationalId, forKey: "CustomerNationalId")
        aCoder.encode(self.DataSake, forKey: "DataSake")
        aCoder.encode(self.DateLicence, forKey: "DateLicence")
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
        aCoder.encode(self.ProjectInvoice, forKey: "ProjectInvoice")
        aCoder.encode(self.ProjectContract, forKey: "ProjectContract")
        aCoder.encode(self.ProjectStatusNum, forKey: "ProjectStatusNum")
        aCoder.encode(self.ProjectBildTypeId, forKey: "ProjectBildTypeId")
        aCoder.encode(self.ProjectEngComment, forKey: "ProjectEngComment")
        aCoder.encode(self.ProjectStatusColor, forKey: "ProjectStatusColor")
        aCoder.encode(self.ProjectStatusID, forKey: "ProjectStatusID")
        aCoder.encode(self.ProjectStatusName, forKey: "ProjectStatusName")
        aCoder.encode(self.ProjectTitle, forKey: "ProjectTitle")
        aCoder.encode(self.ProjectTypeId, forKey: "ProjectTypeId")
        aCoder.encode(self.ProjectTypeName, forKey: "ProjectTypeName")
        aCoder.encode(self.SakNum, forKey: "SakNum")
        aCoder.encode(self.Space, forKey: "Space")
        aCoder.encode(self.Status, forKey: "EmpMobile")
        aCoder.encode(self.TotalNotPaid, forKey: "TotalNotPaid")
        aCoder.encode(self.TotalPaid, forKey: "TotalPaid")
        aCoder.encode(self.ZoomBranch, forKey: "ZoomBranch")
        aCoder.encode(self.ZoomPrj, forKey: "ZoomPrj")
        aCoder.encode(self.projectOrderContractPhotoPath, forKey: "projectOrderContractPhotoPath")
        aCoder.encode(self.ProvincesName, forKey: "ProvincesName")
        aCoder.encode(self.SectoinName, forKey: "SectoinName")
        aCoder.encode(self.ProjectsOrdersCellarErea, forKey: "ProjectsOrdersCellarErea")
        aCoder.encode(self.ProjectsOrdersReFloorErea, forKey: "ProjectsOrdersReFloorErea")
        aCoder.encode(self.ProjectsOrdersSupplementErea, forKey: "ProjectsOrdersSupplementErea")
        aCoder.encode(self.ProjectsOrdersSupplementExternalErea, forKey: "ProjectsOrdersSupplementExternalErea")
        aCoder.encode(self.ProjectsOrdersFloorErea, forKey: "ProjectsOrdersFloorErea")
        aCoder.encode(self.ProjectsOrdersLandErea, forKey: "ProjectsOrdersLandErea")
        aCoder.encode(self.ProjectsOrdersFloorNummber, forKey: "ProjectsOrdersFloorNummber")
        aCoder.encode(self.ProjectsOrdersTotalBildErea, forKey: "ProjectsOrdersTotalBildErea")
        aCoder.encode(self.ProjectsPaymentsWork, forKey: "ProjectsPaymentsWork")
        aCoder.encode(self.ProjectsPaymentsDiscount, forKey: "ProjectsPaymentsDiscount")
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")
        aCoder.encode(self.CompanyAddress, forKey: "CompanyAddress")
        aCoder.encode(self.Logo, forKey: "Logo")
        aCoder.encode(self.isCompany, forKey: "isCompany")
        aCoder.encode(self.DesignNewCount, forKey: "DesignNewCount")
        aCoder.encode(self.DesignCount, forKey: "DesignCount")
        aCoder.encode(self.MeetingDate, forKey: "MeetingDate")
        aCoder.encode(self.MeetingTime, forKey: "MeetingTime")
        aCoder.encode(self.ProjectLastComment, forKey: "ProjectLastComment")
        aCoder.encode(self.ProjectLastTpye, forKey: "ProjectLastTpye")
        aCoder.encode(self.ProjectCommentOther, forKey: "ProjectCommentOther")
        aCoder.encode(self.LastDesignStagesID, forKey: "LastDesignStagesID")
        aCoder.encode(self.MeetingNotifiCount, forKey: "MeetingNotifiCount")
        aCoder.encode(self.DesignNotifiCount, forKey: "DesignNotifiCount")
        aCoder.encode(self.NotifiCount, forKey: "NotifiCount")
        aCoder.encode(self.Meetingcount, forKey: "Meetingcount")
        aCoder.encode(self.FileCount, forKey: "FileCount")
        aCoder.encode(self.ProjectFileCount, forKey: "ProjectFileCount")
         aCoder.encode(self.DocCount, forKey: "DocCount")
    }
}



class ProjectsDetialsModel : NSObject {
    
    var projectDetialsArray = [ProjectDetialsArray]()
    var filter = [ProjectDetialsArray]()
    var itemsStringValue : String {
        var allString = ""
        for item in self.projectDetialsArray {
            allString += "\(item.ProjectId!):\(item.ProjectTitle!),"
        }
        return allString
    }
    
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
        return self.documentsDirectory + "/ProjectDetials.plist"
    }
    
    func append(_ item: ProjectDetialsArray) {
        if projectDetialsArray.contains(where: {$0.ProjectId == item.ProjectId}) {
            print("ite: \(item)")
//            let index = self.projectDetialsArray.index(of: item)
//            self.projectDetialsArray.remove(at: index!)
//            print("todo: \(self.projectDetialsArray)")
//            self.projectDetialsArray.insert(item, at: index!)
//            print("todo2: \(self.projectDetialsArray)")
        }else {
            self.projectDetialsArray.append(item)
            self.saveItems()
        }
    }
    
    func returnProjectDetials(at projectId: String) -> ProjectDetialsArray? {
        return projectDetialsArray.filter({ $0.ProjectId == projectId}).first!
    }
    
    func remove(at index: Int) {
        self.projectDetialsArray.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.projectDetialsArray = unarchiver.decodeObject(forKey: "ProjectDetials") as! [ProjectDetialsArray]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.projectDetialsArray, forKey: "ProjectDetials")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.projectDetialsArray.removeAll()
        self.saveItems()
    }
    
}
