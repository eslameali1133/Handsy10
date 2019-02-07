
//  DesignsCountByCustmoerId.swift
//  Handsy
//  Created by apple on 1/20/19.
//  Copyright © 2019 Ahmed Wahdan. All rights reserved.
//

import Foundation

class DesignsCountByCustmoerId: NSObject, NSCoding {
    var FinishDesignsCount: String?
    var NewDesignsCount: String?
    
    init(FinishDesignsCount: String, NewDesignsCount: String){
        self.FinishDesignsCount = FinishDesignsCount
        self.NewDesignsCount = NewDesignsCount
    }
    
     public required init?(coder aDecoder: NSCoder) {
        self.FinishDesignsCount = aDecoder.decodeObject(forKey: "FinishDesignsCount")  as? String
        self.NewDesignsCount = aDecoder.decodeObject(forKey: "NewDesignsCount")  as? String
    }
    
      public func encode(with aCoder: NSCoder)  {
        aCoder.encode(self.FinishDesignsCount, forKey: "FinishDesignsCount")
        aCoder.encode(self.NewDesignsCount, forKey: "NewDesignsCount")
    }
    
    
}

class DesignsCountByCustmoerIdModel : NSObject {
    
    var DesignsCountByCustmoer = [DesignsCountByCustmoerId]()
    var filter = [DesignsCountByCustmoerId]()
    var itemsStringValue : String {
        var allString = ""
        for item in self.DesignsCountByCustmoer {
            allString += "\(item.FinishDesignsCount!):\(item.NewDesignsCount!),"
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
        return self.documentsDirectory + "/DesignsCountByCustmoerId.plist"
    }
    
    func append(_ item: DesignsCountByCustmoerId) {
        
        self.DesignsCountByCustmoer.append(item)
        self.saveItems()
        
    }
    
    func returnDesignsCountByCustmoerId() -> DesignsCountByCustmoerId? {
        return DesignsCountByCustmoer[0]
    }
    
    func remove(at index: Int) {
        self.DesignsCountByCustmoer.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.DesignsCountByCustmoer = unarchiver.decodeObject(forKey: "DesignsCountByCustmoerId") as! [DesignsCountByCustmoerId]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.DesignsCountByCustmoer, forKey: "DesignsCountByCustmoerId")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.DesignsCountByCustmoer.removeAll()
        self.saveItems()
    }
    
}

