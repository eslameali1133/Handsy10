//
//  GetProjectGallery.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/9/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class GetProjectGallery: NSObject, NSCoding {
    var ProjectGalleryName: String?
    var ProjectGalleryPath: String?
    var CompanyInfoID: String?
    var isSelected = false
    init(ProjectGalleryName: String, ProjectGalleryPath: String, CompanyInfoID: String) {
        self.ProjectGalleryName = ProjectGalleryName
        self.ProjectGalleryPath = ProjectGalleryPath
        self.CompanyInfoID = CompanyInfoID
    }
    public required init?(coder aDecoder: NSCoder) {
        self.ProjectGalleryName = aDecoder.decodeObject(forKey: "ProjectGalleryName") as? String
        self.ProjectGalleryPath = aDecoder.decodeObject(forKey: "ProjectGalleryPath") as? String
        self.CompanyInfoID = aDecoder.decodeObject(forKey: "CompanyInfoID") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.ProjectGalleryName, forKey: "ProjectGalleryName")
        aCoder.encode(self.ProjectGalleryPath, forKey: "ProjectGalleryPath")
        aCoder.encode(self.CompanyInfoID, forKey: "CompanyInfoID")
    }
}
class ProjectGalleryModel: NSObject {
    
    var dicprojectGalleryArray = [String: [GetProjectGallery]]()
    
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
        return self.documentsDirectory + "/projectGallery.plist"
    }
    
    func append(_ item: [GetProjectGallery], index: String) {
        dicprojectGalleryArray[index] = item
        self.saveItems()
    }
    
    func returnProjectDetials(at companyInfoID: String) -> [GetProjectGallery]? {
        return dicprojectGalleryArray[companyInfoID]
    }
    
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.dicprojectGalleryArray = unarchiver.decodeObject(forKey: "projectGallery") as! [String: [GetProjectGallery]]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.dicprojectGalleryArray, forKey: "projectGallery")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.dicprojectGalleryArray.removeAll()
        self.saveItems()
    }
    
}

class GetAllCompanyGallery_AllArray: NSObject {
    var CompanyGalleryName: String = ""
    var CompanyGalleryPath: String = ""
    var isSelected = false
}
