//
//  ProjectFilesArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 10/1/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ProjectFilesArray: NSObject, NSCoding {
    var ProjectFileAttached: String?
    var ProjectFileName: String?
    var ProjectFileSubCategoryName: String?
    var ComapnyName: String?
    var ProjectId: String?
    init(ProjectFileAttached: String, ProjectFileName: String, ProjectFileSubCategoryName: String, ComapnyName: String, ProjectId: String) {
        self.ProjectFileAttached = ProjectFileAttached
        self.ProjectFileName = ProjectFileName
        self.ProjectFileSubCategoryName = ProjectFileSubCategoryName
        self.ComapnyName = ComapnyName
    }
    public required init?(coder aDecoder: NSCoder) {
        self.ProjectFileAttached = aDecoder.decodeObject(forKey: "ProjectFileAttached") as? String
        self.ProjectFileName = aDecoder.decodeObject(forKey: "ProjectFileName") as? String
        self.ProjectFileSubCategoryName = aDecoder.decodeObject(forKey: "ProjectFileSubCategoryName") as? String
        self.ComapnyName = aDecoder.decodeObject(forKey: "ComapnyName") as? String
        self.ProjectId = aDecoder.decodeObject(forKey: "ProjectId") as? String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.ProjectFileAttached, forKey: "ProjectFileAttached")
        aCoder.encode(self.ProjectFileName, forKey: "ProjectFileName")
        aCoder.encode(self.ProjectFileSubCategoryName, forKey: "ProjectFileSubCategoryName")
        aCoder.encode(self.ComapnyName, forKey: "ComapnyName")
        aCoder.encode(self.ProjectId, forKey: "ProjectId")
    }
}

class ProjectFilesProjectIdModel: NSObject {
    var dicProjectFilesProjectId = [String: [ProjectFilesArray]]()
    
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
        return self.documentsDirectory + "/ProjectFilesProjectId.plist"
    }
    
    func append(_ item: [ProjectFilesArray], index: String) {
        dicProjectFilesProjectId[index] = item
        self.saveItems()
    }
    
    func returnProjectDetials(at projectId: String) -> [ProjectFilesArray]? {
        return dicProjectFilesProjectId[projectId]
    }
    
    //    func remove(at index: Int) {
    //        self.arrayServiceOfCompany.remove(at: index)
    //        self.saveItems()
    //    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.dicProjectFilesProjectId = unarchiver.decodeObject(forKey: "ProjectFilesProjectId") as! [String: [ProjectFilesArray]]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.dicProjectFilesProjectId, forKey: "ProjectFilesProjectId")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.dicProjectFilesProjectId.removeAll()
        self.saveItems()
    }
    
}
