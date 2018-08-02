//
//  AboutArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 3/1/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class AboutArray: NSObject, NSCoding {
    var AboutTitle: String?
    var AboutContent: String?
    var ExperTitle: String?
    var ExperContent: String?
    var CompanyInfoID: String?
    init(AboutTitle: String, AboutContent: String, ExperTitle: String, ExperContent: String, CompanyInfoID: String) {
        self.AboutTitle = AboutTitle
        self.AboutContent = AboutContent
        self.ExperTitle = ExperTitle
        self.ExperContent = ExperContent
        self.CompanyInfoID = CompanyInfoID
    }
    public required init?(coder aDecoder: NSCoder) {
        self.AboutTitle = aDecoder.decodeObject(forKey: "AboutTitle") as? String
        self.AboutContent = aDecoder.decodeObject(forKey: "AboutContent") as? String
        self.ExperTitle = aDecoder.decodeObject(forKey: "ExperTitle") as? String
        self.ExperContent = aDecoder.decodeObject(forKey: "ExperContent") as? String
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.AboutTitle, forKey: "AboutTitle")
        aCoder.encode(self.AboutContent, forKey: "AboutContent")
        aCoder.encode(self.ExperTitle, forKey: "ExperTitle")
        aCoder.encode(self.ExperContent, forKey: "ExperContent")
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
    }
}

class AboutModel: NSObject {
    var aboutArray = [AboutArray]()
    
    var itemsStringValue : String {
        var allString = ""
        for item in self.aboutArray {
            allString += "\(item.AboutTitle!):\(item.ExperTitle!),"
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
        return self.documentsDirectory + "/aboutOffice.plist"
    }
    
    func append(_ item: AboutArray) {
        if aboutArray.contains(where: {$0.CompanyInfoID == item.CompanyInfoID}) {
            print("ite: \(item)")
            //            let index = self.projectDetialsArray.index(of: item)
            //            self.projectDetialsArray.remove(at: index!)
            //            print("todo: \(self.projectDetialsArray)")
            //            self.projectDetialsArray.insert(item, at: index!)
            //            print("todo2: \(self.projectDetialsArray)")
        }else {
            self.aboutArray.append(item)
            self.saveItems()
        }
    }
    
    func returnProjectDetials(at companyInfoID: String) -> AboutArray? {
        return aboutArray.filter({ $0.CompanyInfoID == companyInfoID}).first!
    }
    
    func remove(at index: Int) {
        self.aboutArray.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.aboutArray = unarchiver.decodeObject(forKey: "aboutOffice") as! [AboutArray]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.aboutArray, forKey: "aboutOffice")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.aboutArray.removeAll()
        self.saveItems()
    }
    
}
