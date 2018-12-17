//
//  CollectedArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/16/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class CollectedArray: NSObject, NSCoding {
    var CustmoerId: String = ""
    var CustmoerName: String = ""
    var PaymentBatchStatusID: String = ""
    var PaymentBatchStatusName: String = ""
    var PaymentStatus: String = ""
    var PaymentTypeName: String = ""
    var PaymentTypeeID: String = ""
    var PaymentValue: String = ""
    var ProjectId: String = ""
    var ProjectContract: String = ""
    var ProjectTitle: String = ""
    var ProjectTypeName: String = ""
    var ProjectsOrdersId: String = ""
    var ProjectsPaymentsId: String = ""
    var ProjectsPaymentsNumber: String = ""
    var RefranceId: String = ""
    var projectOrderInvoicePhotoPath: String = ""
    var projectOrderContractPhotoPath: String = ""
    var PayDate: String = ""
    var PayDateHijri: String = ""
    var PayTime: String = ""
    var ComapnyName: String = ""
    var LatBranch: Double = 0.0
    var LngBranch: Double = 0.0
    var isSelected = false
    var EmpPhone = ""
    var EmpName = ""
    init(CustmoerId: String, CustmoerName: String, PaymentBatchStatusID: String, PaymentBatchStatusName: String, PaymentStatus: String, PaymentTypeName: String, PaymentTypeeID: String, PaymentValue: String, ProjectId: String, ProjectContract: String, ProjectTitle: String, ProjectTypeName: String, ProjectsOrdersId: String, ProjectsPaymentsId: String, ProjectsPaymentsNumber: String, RefranceId: String, projectOrderInvoicePhotoPath: String, projectOrderContractPhotoPath: String, PayDate: String, PayDateHijri: String, PayTime: String, ComapnyName: String, LatBranch: Double, LngBranch: Double , EmpPhone: String , EmpName: String) {
        self.CustmoerId = CustmoerId
        self.CustmoerName = CustmoerName
        self.PaymentBatchStatusID = PaymentBatchStatusID
        self.PaymentBatchStatusName = PaymentBatchStatusName
        self.PaymentStatus = PaymentStatus
        self.PaymentTypeName = PaymentTypeName
        self.PaymentTypeeID = PaymentTypeeID
        self.PaymentValue = PaymentValue
        self.ProjectId = ProjectId
        self.ProjectContract = ProjectContract
        self.ProjectTitle = ProjectTitle
        self.ProjectTypeName = ProjectTypeName
        self.ProjectsOrdersId = ProjectsOrdersId
        self.ProjectsPaymentsId = ProjectsPaymentsId
        self.ProjectsPaymentsNumber = ProjectsPaymentsNumber
        self.RefranceId = RefranceId
        self.projectOrderInvoicePhotoPath = projectOrderInvoicePhotoPath
        self.projectOrderContractPhotoPath = projectOrderContractPhotoPath
        self.PayDate = PayDate
        self.PayDateHijri = PayDateHijri
        self.PayTime = PayTime
        self.ComapnyName = ComapnyName
        self.LatBranch = LatBranch
        self.LngBranch = LngBranch
        self.EmpPhone = EmpPhone
        self.EmpName = EmpName
    }
    public required init?(coder aDecoder: NSCoder) {
        self.CustmoerId = aDecoder.decodeObject(forKey: "CustmoerId") as! String
        self.CustmoerName = aDecoder.decodeObject(forKey: "CustmoerName") as! String
        self.PaymentBatchStatusID = aDecoder.decodeObject(forKey: "PaymentBatchStatusID") as! String
        self.PaymentBatchStatusName = aDecoder.decodeObject(forKey: "PaymentBatchStatusName") as! String
        self.PaymentStatus = aDecoder.decodeObject(forKey: "PaymentStatus") as! String
        self.PaymentTypeName = aDecoder.decodeObject(forKey: "PaymentTypeName") as! String
        self.PaymentTypeeID = aDecoder.decodeObject(forKey: "PaymentTypeeID") as! String
        self.PaymentValue = aDecoder.decodeObject(forKey: "PaymentValue") as! String
        self.ProjectId = aDecoder.decodeObject(forKey: "ProjectId") as! String
        self.ProjectContract = aDecoder.decodeObject(forKey: "ProjectContract") as! String
        self.ProjectTitle = aDecoder.decodeObject(forKey: "ProjectTitle") as! String
        self.ProjectTypeName = aDecoder.decodeObject(forKey: "ProjectTypeName") as! String
        self.ProjectsOrdersId = aDecoder.decodeObject(forKey: "ProjectsOrdersId") as! String
        self.ProjectsPaymentsId = aDecoder.decodeObject(forKey: "ProjectsPaymentsId") as! String
        self.ProjectsPaymentsNumber = aDecoder.decodeObject(forKey: "ProjectsPaymentsNumber") as! String
        self.RefranceId = aDecoder.decodeObject(forKey: "RefranceId") as! String
        self.projectOrderInvoicePhotoPath = aDecoder.decodeObject(forKey: "projectOrderInvoicePhotoPath") as! String
        self.projectOrderContractPhotoPath = aDecoder.decodeObject(forKey: "projectOrderContractPhotoPath") as! String
        self.PayDate = aDecoder.decodeObject(forKey: "PayDate") as! String
        self.PayDateHijri = aDecoder.decodeObject(forKey: "PayDateHijri") as! String
        self.PayTime = aDecoder.decodeObject(forKey: "PayTime") as! String
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName") as! String
        self.LatBranch = aDecoder.decodeDouble(forKey: "LatBranch")
        self.LngBranch = aDecoder.decodeDouble(forKey: "LngBranch")
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.CustmoerId, forKey: "CustmoerId")
        aCoder.encode(self.CustmoerName, forKey: "CustmoerName")
        aCoder.encode(self.PaymentBatchStatusID, forKey: "PaymentBatchStatusID")
        aCoder.encode(self.PaymentBatchStatusName, forKey: "PaymentBatchStatusName")
        aCoder.encode(self.PaymentStatus, forKey: "PaymentStatus")
        aCoder.encode(self.PaymentTypeName, forKey: "PaymentTypeName")
        aCoder.encode(self.PaymentTypeeID, forKey: "PaymentTypeeID")
        aCoder.encode(self.PaymentValue, forKey: "PaymentValue")
        aCoder.encode(self.ProjectId, forKey: "ProjectId")
        aCoder.encode(self.ProjectContract, forKey: "ProjectContract")
        aCoder.encode(self.ProjectTitle, forKey: "ProjectTitle")
        aCoder.encode(self.ProjectTypeName, forKey: "ProjectTypeName")
        aCoder.encode(self.ProjectsOrdersId, forKey: "ProjectsOrdersId")
        aCoder.encode(self.ProjectsPaymentsId, forKey: "ProjectsPaymentsId")
        aCoder.encode(self.ProjectsPaymentsNumber, forKey: "ProjectsPaymentsNumber")
        aCoder.encode(self.RefranceId, forKey: "RefranceId")
        aCoder.encode(self.projectOrderInvoicePhotoPath, forKey: "projectOrderInvoicePhotoPath")
        aCoder.encode(self.projectOrderContractPhotoPath, forKey: "projectOrderContractPhotoPath")
        aCoder.encode(self.PayDate, forKey: "PayDate")
        aCoder.encode(self.PayDateHijri, forKey: "PayDateHijri")
        aCoder.encode(self.PayTime, forKey: "PayTime")
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")
        aCoder.encode(self.LatBranch, forKey: "LatBranch")
        aCoder.encode(self.LngBranch, forKey: "LngBranch")
        
    }
}

class CollectedMoneyDetialsModel : NSObject {
    
    var collectedArray = [CollectedArray]()
    
    var itemsStringValue : String {
        var allString = ""
        for item in self.collectedArray {
            allString += "\(item.ProjectId):\(item.ProjectTitle),"
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
        return self.documentsDirectory + "/collectedMoney.plist"
    }
    
    func append(_ item: CollectedArray) {
        if self.collectedArray.contains(item) {
            let index = self.collectedArray.index(of: item)
            self.collectedArray[index!].ProjectTitle += item.ProjectTitle
        } else {
            self.collectedArray.append(item)
        }
        self.saveItems()
    }
    
    
    
    func remove(at index: Int) {
        self.collectedArray.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.collectedArray = unarchiver.decodeObject(forKey: "collectedMoney") as! [CollectedArray]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.collectedArray, forKey: "collectedMoney")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.collectedArray.removeAll()
        self.saveItems()
    }
    
}
