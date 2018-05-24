//
//  DetialsOfOfficeArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class DetialsOfOfficeArray: NSObject, NSCoding {
    var Address: String?
    var BranchFB: String?
    var BranchID: String?
    var BranchName: String?
    var ComapnyName: String?
    var CommercialNumber: String?
    var CompanyEmail: String?
    var CompanyInfoID: String?
    var CompanyMobile: String?
    var Fax: String?
    var Lat: Double?
    var Long: Double?
    var LicenceNumber: String?
    var Logo: String?
    var OfficeWebsite: String?
    var Phone: String?
    var PostNumber: String?
    var PostNumberWasl: String?
    var PostSymbol: String?
    var Specialty: String?
    var Zoom: Double?
    
    init(Address: String, BranchFB: String, BranchID: String, BranchName: String, ComapnyName: String, CommercialNumber: String, CompanyEmail: String, CompanyInfoID: String, CompanyMobile: String, Fax: String, Lat: Double, Long: Double, LicenceNumber: String, Logo: String, OfficeWebsite: String, Phone: String, PostNumber: String, PostNumberWasl: String, PostSymbol: String, Specialty: String, Zoom: Double) {
        self.Address = Address
        self.BranchFB = BranchFB
        self.BranchID = BranchID
        self.BranchName = BranchName
        self.ComapnyName = ComapnyName
        self.CommercialNumber = CommercialNumber
        self.CompanyEmail = CompanyEmail
        self.CompanyInfoID = CompanyInfoID
        self.CompanyMobile = CompanyMobile
        self.Fax = Fax
        self.Lat = Lat
        self.Long = Long
        self.LicenceNumber = LicenceNumber
        self.Logo = Logo
        self.OfficeWebsite = OfficeWebsite
        self.Phone = Phone
        self.PostNumber = PostNumber
        self.PostNumberWasl = PostNumberWasl
        self.PostSymbol = PostSymbol
        self.Specialty = Specialty
        self.Zoom = Zoom
    }
    public required init?(coder aDecoder: NSCoder) {
        self.Address = aDecoder.decodeObject(forKey: "Address") as? String
        self.BranchFB = aDecoder.decodeObject(forKey: "BranchFB") as? String
        self.BranchID = aDecoder.decodeObject(forKey: "BranchID") as? String
        self.BranchName = aDecoder.decodeObject(forKey: "BranchName") as? String
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName") as? String
        self.CommercialNumber = aDecoder.decodeObject(forKey: "CommercialNumber") as? String
        self.CompanyEmail = aDecoder.decodeObject(forKey: "CompanyEmail") as? String
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID") as? String
        self.CompanyMobile = aDecoder.decodeObject(forKey: "CompanyMobile") as? String
        self.Fax = aDecoder.decodeObject(forKey: "Fax") as? String
        self.Lat = aDecoder.decodeObject(forKey: "Lat") as? Double
        self.Long = aDecoder.decodeObject(forKey: "Long") as? Double
        self.LicenceNumber = aDecoder.decodeObject(forKey: "LicenceNumber") as? String
        self.Logo = aDecoder.decodeObject(forKey: "Logo") as? String
        self.OfficeWebsite = aDecoder.decodeObject(forKey: "OfficeWebsite") as? String
        self.Phone = aDecoder.decodeObject(forKey: "Phone") as? String
        self.PostNumber = aDecoder.decodeObject(forKey: "PostNumber") as? String
        self.PostNumberWasl = aDecoder.decodeObject(forKey: "PostNumberWasl") as? String
        self.PostSymbol = aDecoder.decodeObject(forKey: "PostSymbol") as? String
        self.Specialty = aDecoder.decodeObject(forKey: "Specialty") as? String
        self.Zoom = aDecoder.decodeObject(forKey: "Zoom") as? Double
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.Address, forKey: "Address")
        aCoder.encode(self.BranchFB, forKey: "BranchFB")
        aCoder.encode(self.BranchID, forKey: "BranchID")
        aCoder.encode(self.BranchName, forKey: "BranchName")
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")
        aCoder.encode(self.CommercialNumber, forKey: "CommercialNumber")
        aCoder.encode(self.CompanyEmail, forKey: "CompanyEmail")
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
        aCoder.encode(self.CompanyMobile, forKey: "CompanyMobile")
        aCoder.encode(self.Fax, forKey: "Fax")
        aCoder.encode(self.Lat, forKey: "Lat")
        aCoder.encode(self.Long, forKey: "Long")
        aCoder.encode(self.LicenceNumber, forKey: "LicenceNumber")
        aCoder.encode(self.Logo, forKey: "Logo")
        aCoder.encode(self.Phone, forKey: "Phone")
        aCoder.encode(self.PostNumber, forKey: "PostNumber")
        aCoder.encode(self.PostNumberWasl, forKey: "PostNumberWasl")
        aCoder.encode(self.PostSymbol, forKey: "PostSymbol")
        aCoder.encode(self.Specialty, forKey: "Specialty")
        aCoder.encode(self.Zoom, forKey: "Zoom")
    }
}

class DetialsOfOfficeModel : NSObject {
    var detialsOfOfficeArray = [DetialsOfOfficeArray]()
    
    var itemsStringValue : String {
        var allString = ""
        for item in self.detialsOfOfficeArray {
            allString += "\(item.CompanyInfoID!):\(item.CompanyInfoID!),"
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
        return self.documentsDirectory + "/detialsOfOffice.plist"
    }
    
    func append(_ item: DetialsOfOfficeArray) {
        if detialsOfOfficeArray.contains(where: {$0.CompanyInfoID == item.CompanyInfoID}) {
            print("ite: \(item)")
            //            let index = self.projectDetialsArray.index(of: item)
            //            self.projectDetialsArray.remove(at: index!)
            //            print("todo: \(self.projectDetialsArray)")
            //            self.projectDetialsArray.insert(item, at: index!)
            //            print("todo2: \(self.projectDetialsArray)")
        }else {
            self.detialsOfOfficeArray.append(item)
            self.saveItems()
        }
    }
    
    func returnProjectDetials(at companyInfoID: String) -> DetialsOfOfficeArray? {
        return detialsOfOfficeArray.filter({ $0.CompanyInfoID == companyInfoID}).first!
    }
    
    func remove(at index: Int) {
        self.detialsOfOfficeArray.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.detialsOfOfficeArray = unarchiver.decodeObject(forKey: "detialsOfOffice") as! [DetialsOfOfficeArray]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.detialsOfOfficeArray, forKey: "detialsOfOffice")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.detialsOfOfficeArray.removeAll()
        self.saveItems()
    }
    
}
