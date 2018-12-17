//
//  NotCollectedArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/17/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class NotCollectedArray: NSObject, NSCoding {
    var CustmoerId = ""
    var CustmoerName = ""
    var PayDate = ""
    var PaymentBatchStatusID = ""
    var PaymentBatchStatusName = ""
    var PaymentStatus = ""
    var PaymentTypeName = ""
    var PaymentTypeeID = ""
    var PaymentValue = ""
    var ProjectContract = ""
    var ProjectId = ""
    var ProjectTitle = ""
    var ProjectTypeName = ""
    var ProjectsOrdersId = ""
    var ProjectsPaymentsId = ""
    var ProjectsPaymentsNumber = ""
    var RefranceId = ""
    var projectOrderInvoicePhotoPath = ""
    var projectOrderContractPhotoPath = ""
    var ComapnyName = ""
     var EmpName = ""
   var EmpPhone = ""
    
    init(CustmoerId: String, CustmoerName: String, PaymentBatchStatusID: String, PaymentBatchStatusName: String, PaymentStatus: String, PaymentTypeName: String, PaymentTypeeID: String, PaymentValue: String, ProjectId: String, ProjectContract: String, ProjectTitle: String, ProjectTypeName: String, ProjectsOrdersId: String, ProjectsPaymentsId: String, ProjectsPaymentsNumber: String, RefranceId: String, projectOrderInvoicePhotoPath: String, projectOrderContractPhotoPath: String, PayDate: String, ComapnyName: String,EmpName: String , EmpPhone:String) {
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
        self.ComapnyName = ComapnyName
        self.EmpName = EmpName
        self.EmpPhone = EmpPhone
    }
    public required init?(coder aDecoder: NSCoder) {
        self.CustmoerId = aDecoder.decodeObject(forKey: "CustmoerId") as! String
        self.CustmoerName = aDecoder.decodeObject(forKey: "CustmoerName") as! String
//        self.EmpName = aDecoder.decodeObject(forKey: "EmpName") as! String
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
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName") as! String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.CustmoerId, forKey: "CustmoerId")
        aCoder.encode(self.CustmoerName, forKey: "CustmoerName")
//           aCoder.encode(self.EmpName, forKey: "EmpName")
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
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")        
    }
}

class NotCollectedMoneyDetialsModel : NSObject {
    
    var notCollectedArray = [NotCollectedArray]()
    
    var itemsStringValue : String {
        var allString = ""
        for item in self.notCollectedArray {
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
        return self.documentsDirectory + "/notCollectedMoney.plist"
    }
    
    func append(_ item: NotCollectedArray) {
        if self.notCollectedArray.contains(item) {
            let index = self.notCollectedArray.index(of: item)
            self.notCollectedArray[index!].ProjectTitle += item.ProjectTitle
        } else {
            self.notCollectedArray.append(item)
        }
        self.saveItems()
    }
    
    
    
    func remove(at index: Int) {
        self.notCollectedArray.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.notCollectedArray = unarchiver.decodeObject(forKey: "notCollectedMoney") as! [NotCollectedArray]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.notCollectedArray, forKey: "notCollectedMoney")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.notCollectedArray.removeAll()
        self.saveItems()
    }
    
}
