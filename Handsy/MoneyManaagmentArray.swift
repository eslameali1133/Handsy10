//
//  MoneyManaagmentArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 9/18/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class MoneyManaagmentArray: NSObject, NSCoding {
    var CustmoerId: String?
    var CustmoerName: String?
    var PayDate: String?
    var PayDateHijri: String?
    var PayTime: String?
    var PaymentBatchStatusID: String?
    var PaymentBatchStatusName: String?
    var PaymentStatus: String?
    var PaymentTypeName: String?
    var PaymentTypeeID: String?
    var PaymentValue: String?
    var ProjectId: String?
    var ProjectTitle: String?
    var ProjectTypeName: String?
    var ProjectsOrdersId: String?
    var ProjectsPaymentsId: String?
    var ProjectsPaymentsNumber: String?
    var RefranceId: String?
    var projectOrderInvoicePhotoPath: String?
    var isSelected = false
    
    init(CustmoerId: String, CustmoerName: String, PayDate: String, PayDateHijri: String, PayTime: String, PaymentBatchStatusID: String, PaymentBatchStatusName: String, PaymentStatus: String, PaymentTypeName: String, PaymentTypeeID: String, PaymentValue: String, ProjectId: String, ProjectTitle: String, ProjectTypeName: String, ProjectsOrdersId: String, ProjectsPaymentsId: String, ProjectsPaymentsNumber: String, RefranceId: String, projectOrderInvoicePhotoPath: String) {
        self.CustmoerId = CustmoerId
        self.CustmoerName = CustmoerName
        self.PayDate = PayDate
        self.PayDateHijri = PayDateHijri
        self.PayTime = PayTime
        self.PaymentBatchStatusID = PaymentBatchStatusID
        self.PaymentBatchStatusName = PaymentBatchStatusName
        self.PaymentStatus = PaymentStatus
        self.PaymentTypeName = PaymentTypeName
        self.PaymentTypeeID = PaymentTypeeID
        self.PaymentValue = PaymentValue
        self.ProjectId = ProjectId
        self.ProjectTitle = ProjectTitle
        self.ProjectTypeName = ProjectTypeName
        self.ProjectsOrdersId = ProjectsOrdersId
        self.ProjectsPaymentsId = ProjectsPaymentsId
        self.ProjectsPaymentsNumber = ProjectsPaymentsNumber
        self.RefranceId = RefranceId
        self.projectOrderInvoicePhotoPath = projectOrderInvoicePhotoPath
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.CustmoerId = aDecoder.decodeObject(forKey: "CustmoerId") as? String
        self.CustmoerName = aDecoder.decodeObject(forKey: "CustmoerName") as? String
        self.PayDate = aDecoder.decodeObject(forKey: "PayDate") as? String
        self.PayDateHijri = aDecoder.decodeObject(forKey: "PayDateHijri") as? String
        self.PayTime = aDecoder.decodeObject(forKey: "PayTime") as? String
        self.PaymentBatchStatusID = aDecoder.decodeObject(forKey: "PaymentBatchStatusID") as? String
        self.PaymentBatchStatusName = aDecoder.decodeObject(forKey: "PaymentBatchStatusName") as? String
        self.PaymentStatus = aDecoder.decodeObject(forKey: "PaymentStatus") as? String
        self.PaymentTypeName = aDecoder.decodeObject(forKey: "PaymentTypeName") as? String
        self.PaymentTypeeID = aDecoder.decodeObject(forKey: "PaymentTypeeID") as? String
        self.PaymentValue = aDecoder.decodeObject(forKey: "PaymentValue") as? String
        self.ProjectId = aDecoder.decodeObject(forKey: "ProjectId") as? String
        self.ProjectTitle = aDecoder.decodeObject(forKey: "ProjectTitle") as? String
        self.ProjectTypeName = aDecoder.decodeObject(forKey: "ProjectTypeName") as? String
        self.ProjectsOrdersId = aDecoder.decodeObject(forKey: "ProjectsOrdersId") as? String
        self.ProjectsPaymentsId = aDecoder.decodeObject(forKey: "ProjectsPaymentsId") as? String
        self.ProjectsPaymentsNumber = aDecoder.decodeObject(forKey: "ProjectsPaymentsNumber") as? String
        self.RefranceId = aDecoder.decodeObject(forKey: "RefranceId") as? String
        self.projectOrderInvoicePhotoPath = aDecoder.decodeObject(forKey: "projectOrderInvoicePhotoPath") as? String
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.CustmoerId, forKey: "CustmoerId")
        aCoder.encode(self.CustmoerName, forKey: "CustmoerName")
        aCoder.encode(self.PayDate, forKey: "PayDate")
        aCoder.encode(self.PayDateHijri, forKey: "PayDateHijri")
        aCoder.encode(self.PayTime, forKey: "PayTime")
        aCoder.encode(self.PaymentBatchStatusID, forKey: "PaymentBatchStatusID")
        aCoder.encode(self.PaymentBatchStatusName, forKey: "PaymentBatchStatusName")
        aCoder.encode(self.PaymentStatus, forKey: "PaymentStatus")
        aCoder.encode(self.PaymentTypeName, forKey: "PaymentTypeName")
        aCoder.encode(self.PaymentTypeeID, forKey: "PaymentTypeeID")
        aCoder.encode(self.PaymentValue, forKey: "PaymentValue")
        aCoder.encode(self.ProjectId, forKey: "ProjectId")
        aCoder.encode(self.ProjectTitle, forKey: "ProjectTitle")
        aCoder.encode(self.ProjectTypeName, forKey: "ProjectTypeName")
        aCoder.encode(self.ProjectsOrdersId, forKey: "ProjectsOrdersId")
        aCoder.encode(self.ProjectsPaymentsId, forKey: "ProjectsPaymentsId")
        aCoder.encode(self.ProjectsPaymentsNumber, forKey: "ProjectsPaymentsNumber")
        aCoder.encode(self.RefranceId, forKey: "RefranceId")
        aCoder.encode(self.projectOrderInvoicePhotoPath, forKey: "projectOrderInvoicePhotoPath")
    }
}

class MoneyManaagmentModel: NSObject {
    var dicMoneyManaagment = [String: [MoneyManaagmentArray]]()
    
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
        return self.documentsDirectory + "/MoneyManaagment.plist"
    }
    
    func append(_ item: [MoneyManaagmentArray], index: String) {
        dicMoneyManaagment[index] = item
        self.saveItems()
    }
    
    func returnProjectDetials(at projectId: String) -> [MoneyManaagmentArray]? {
        return dicMoneyManaagment[projectId]
    }
    
    //    func remove(at index: Int) {
    //        self.arrayServiceOfCompany.remove(at: index)
    //        self.saveItems()
    //    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.dicMoneyManaagment = unarchiver.decodeObject(forKey: "MoneyManaagment") as! [String: [MoneyManaagmentArray]]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.dicMoneyManaagment, forKey: "MoneyManaagment")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.dicMoneyManaagment.removeAll()
        self.saveItems()
    }
    
}
