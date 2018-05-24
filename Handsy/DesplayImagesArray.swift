//
//  DesplayImagesArray.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 8/23/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit

class DesplayImagesArray: NSObject, NSCoding {
    
    var ProjectsImageID: String = ""
    var ProjectId: String = ""
    var ProjectsImagePath: String = ""
    var ProjectsImageType: String = ""
    var ProjectsImageRotate: String = ""

    init(ProjectsImageID: String, ProjectId: String, ProjectsImagePath: String, ProjectsImageType: String, ProjectsImageRotate: String) {
        self.ProjectsImageID = ProjectsImageID
        self.ProjectId = ProjectId
        self.ProjectsImagePath = ProjectsImagePath
        self.ProjectsImageType = ProjectsImageType
        self.ProjectsImageRotate = ProjectsImageRotate
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.ProjectsImageID = aDecoder.decodeObject(forKey: "ProjectsImageID") as! String
        self.ProjectId = aDecoder.decodeObject(forKey: "ProjectId") as! String
        self.ProjectsImagePath = aDecoder.decodeObject(forKey: "ProjectsImagePath") as! String
        self.ProjectsImageType = aDecoder.decodeObject(forKey: "ProjectsImageType") as! String
        self.ProjectsImageRotate = aDecoder.decodeObject(forKey: "ProjectsImageRotate") as! String
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.ProjectsImageID, forKey: "ProjectsImageID")
        aCoder.encode(self.ProjectId, forKey: "ProjectId")
        aCoder.encode(self.ProjectsImagePath, forKey: "ProjectsImagePath")
        aCoder.encode(self.ProjectsImageType, forKey: "ProjectsImageType")
        aCoder.encode(self.ProjectsImageRotate, forKey: "ProjectsImageRotate")
    }
}

class DisplayImagesModel: NSObject {
    var displayImagesArray = [DesplayImagesArray]()

    var itemsStringValue : String {
        var allString = ""
        for item in self.displayImagesArray {
            allString += "\(item.ProjectId):\(item.ProjectsImageID),"
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
        return self.documentsDirectory + "/displayImages.plist"
    }
    
    func append(_ item: DesplayImagesArray) {
        if displayImagesArray.contains(where: {$0.ProjectId == item.ProjectId}) {
            print("ite: \(item)")
            //            let index = self.projectDetialsArray.index(of: item)
            //            self.projectDetialsArray.remove(at: index!)
            //            print("todo: \(self.projectDetialsArray)")
            //            self.projectDetialsArray.insert(item, at: index!)
            //            print("todo2: \(self.projectDetialsArray)")
        }else {
            self.displayImagesArray.append(item)
            self.saveItems()
        }
    }
    
    
    func returnProjectDetials(at projectId: String) -> DesplayImagesArray? {
        if displayImagesArray.contains(where: {$0.ProjectId == projectId}) {
            return displayImagesArray.filter({ $0.ProjectId == projectId}).first!
        }else {
            return nil
        }
    }
    
    func remove(at index: Int) {
        self.displayImagesArray.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.displayImagesArray = unarchiver.decodeObject(forKey: "displayImages") as! [DesplayImagesArray]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.displayImagesArray, forKey: "displayImages")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.displayImagesArray.removeAll()
        self.saveItems()
    }
    
}
