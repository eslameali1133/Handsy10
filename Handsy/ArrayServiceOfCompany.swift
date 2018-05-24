//
//  ArrayServiceOfCompany.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/19/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ArrayServiceOfCompany: NSObject, NSCoding {
    
    var serviceName: String?
    var content: String?
    var CompanyInfoID: String?
    init(serviceName: String, content: String, CompanyInfoID: String) {
        self.serviceName = serviceName
        self.content = content
        self.CompanyInfoID = CompanyInfoID
    }

    public required init?(coder aDecoder: NSCoder) {
        self.serviceName = aDecoder.decodeObject(forKey: "serviceName") as? String
        self.content = aDecoder.decodeObject(forKey: "content") as? String
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.serviceName, forKey: "serviceName")
        aCoder.encode(self.content, forKey: "content")
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
    }
}

class ServiceModel: NSObject {
    var dicServiceOfCompany = [String: [ArrayServiceOfCompany]]()

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
        return self.documentsDirectory + "/ServiceOfCompany.plist"
    }

    func append(_ item: [ArrayServiceOfCompany], index: String) {
        dicServiceOfCompany[index] = item
        self.saveItems()
    }

    func returnProjectDetials(at companyInfoID: String) -> [ArrayServiceOfCompany]? {
        return dicServiceOfCompany[companyInfoID]
    }

//    func remove(at index: Int) {
//        self.arrayServiceOfCompany.remove(at: index)
//        self.saveItems()
//    }

    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.dicServiceOfCompany = unarchiver.decodeObject(forKey: "ServiceOfCompany") as! [String: [ArrayServiceOfCompany]]
                unarchiver.finishDecoding()
            }
        }
    }

    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.dicServiceOfCompany, forKey: "ServiceOfCompany")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }

    func removeAllItems() {
        self.dicServiceOfCompany.removeAll()
        self.saveItems()
    }
    
}
