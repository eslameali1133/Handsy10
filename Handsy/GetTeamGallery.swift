//
//  GetTeamGallery.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/9/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class GetTeamGallery: NSObject, NSCoding {
    var CompanyInfoID: String?
    var CompanyGalleryName: String?
    var CompanyGalleryPath: String?
    var DateAdded: String?
    var IsDeleted: String?
    var isSelected = false
    init(CompanyInfoID: String, CompanyGalleryName: String, CompanyGalleryPath: String) {
        self.CompanyInfoID = CompanyInfoID
        self.CompanyGalleryName = CompanyGalleryName
        self.CompanyGalleryPath = CompanyGalleryPath
    }
    public required init?(coder aDecoder: NSCoder) {
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID") as? String
        self.CompanyGalleryName = aDecoder.decodeObject(forKey: "CompanyGalleryName") as? String
        self.CompanyGalleryPath = aDecoder.decodeObject(forKey: "CompanyGalleryPath") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
        aCoder.encode(self.CompanyGalleryName, forKey: "CompanyGalleryName")
        aCoder.encode(self.CompanyGalleryPath, forKey: "CompanyGalleryPath")
    }
}

class TeamGalleryModel: NSObject {
    var dicTeamGallery = [String: [GetTeamGallery]]()
    
   
    override init() {
        super.init()
//        self.loadItems()
    }
    
    deinit {
        self.saveItems()
    }
    
    var documentsDirectory : String {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
    }
    
    var itemsPath : String {
        return self.documentsDirectory + "/TeamGallery.plist"
    }
    
    func append(_ item: [GetTeamGallery], index: String) {
        dicTeamGallery[index] = item
        self.saveItems()
    }
    
    func returnProjectDetials(at companyInfoID: String) -> [GetTeamGallery]? {
        return dicTeamGallery[companyInfoID]
    }
    
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.dicTeamGallery = unarchiver.decodeObject(forKey: "TeamGallery") as! [String: [GetTeamGallery]]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.dicTeamGallery, forKey: "TeamGallery")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.dicTeamGallery.removeAll()
        self.saveItems()
    }
    
}
