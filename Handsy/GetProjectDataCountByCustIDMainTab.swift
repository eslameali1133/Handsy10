//
//  DesignsCountByCustmoerId.swift
//  Handsy
//
//  Created by apple on 1/20/19.
//  Copyright © 2019 Ahmed Wahdan. All rights reserved.
//

import Foundation

class GetProjectDataCountByCustIDMainTab: NSObject, NSCoding {
    var DesignsCount: Int?
    var MeetingCount: Int?
      var FileCount: Int?
    
    init(DesignsCount: Int, MeetingCount: Int, FileCount: Int){
        self.DesignsCount = DesignsCount
        self.MeetingCount = MeetingCount
         self.FileCount = FileCount
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.DesignsCount = aDecoder.decodeObject(forKey: "DesignsCount")  as? Int
        self.MeetingCount = aDecoder.decodeObject(forKey: "MeetingCount")  as? Int
          self.FileCount = aDecoder.decodeObject(forKey: "FileCount")  as? Int
    }
    
    public func encode(with aCoder: NSCoder)  {
        aCoder.encode(self.DesignsCount, forKey: "DesignsCount")
        aCoder.encode(self.MeetingCount, forKey: "MeetingCount")
         aCoder.encode(self.FileCount, forKey: "FileCount")
    }
    
    
}

class GetProjectDataCountByCustIDMainTabdModel : NSObject {
    
    var GetProjectDataCountByCustIDMainTabArry = [GetProjectDataCountByCustIDMainTab]()
    var filter = [GetProjectDataCountByCustIDMainTab]()
    var itemsStringValue : String {
        var allString = ""
        for item in self.GetProjectDataCountByCustIDMainTabArry {
            allString += "\(item.DesignsCount!):\(item.FileCount!) :\(item.MeetingCount!),"
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
        return self.documentsDirectory + "/GetProjectDataCountByCustID.plist"
    }
    
    func append(_ item: GetProjectDataCountByCustIDMainTab) {
        
        self.GetProjectDataCountByCustIDMainTabArry.append(item)
        self.saveItems()
        
    }
    
    func returnCountByCustmoerId() -> GetProjectDataCountByCustIDMainTab? {
        return GetProjectDataCountByCustIDMainTabArry[0]
    }
    
    func remove(at index: Int) {
        self.GetProjectDataCountByCustIDMainTabArry.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.GetProjectDataCountByCustIDMainTabArry = unarchiver.decodeObject(forKey: "GetProjectDataCountByCustID") as! [GetProjectDataCountByCustIDMainTab]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.GetProjectDataCountByCustIDMainTabArry, forKey: "GetProjectDataCountByCustID")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.GetProjectDataCountByCustIDMainTabArry.removeAll()
        self.saveItems()
    }
    
}

