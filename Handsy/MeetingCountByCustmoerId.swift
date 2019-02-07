//
//  MeetingCountByCustmoerId.swift
//  Handsy
//
//  Created by apple on 1/22/19.
//  Copyright © 2019 Ahmed Wahdan. All rights reserved.
//


import Foundation

class MeetingCountByCustmoerIdclass: NSObject, NSCoding {
    var FinishMeetingCount: String?
    var NewMeetingCount: String?
    
    init(FinishMeetingCount: String, NewMeetingCount: String){
        self.FinishMeetingCount = FinishMeetingCount
        self.NewMeetingCount = NewMeetingCount
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.FinishMeetingCount = aDecoder.decodeObject(forKey: "FinishMeetingCount")  as? String
        self.NewMeetingCount = aDecoder.decodeObject(forKey: "NewMeetingCount")  as? String
    }
    
    public func encode(with aCoder: NSCoder)  {
        aCoder.encode(self.FinishMeetingCount, forKey: "FinishMeetingCount")
        aCoder.encode(self.NewMeetingCount, forKey: "NewMeetingCount")
    }
    
    
}

class MeetingCountByCustmoerIdModel : NSObject {
    
    var MeetingCountByCustmoer = [MeetingCountByCustmoerIdclass]()
    var filter = [MeetingCountByCustmoerIdclass]()
    var itemsStringValue : String {
        var allString = ""
        for item in self.MeetingCountByCustmoer {
            allString += "\(item.FinishMeetingCount!):\(item.NewMeetingCount!),"
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
        return self.documentsDirectory + "/MeetingCountByCustmoerId.plist"
    }
    
    func append(_ item: MeetingCountByCustmoerIdclass) {
        
        self.MeetingCountByCustmoer.append(item)
        self.saveItems()
        
    }
    
    func returnmeetingsCountByCustmoerId() -> MeetingCountByCustmoerIdclass? {
        return MeetingCountByCustmoer[0]
    }
    
    func remove(at index: Int) {
        self.MeetingCountByCustmoer.remove(at: index)
        self.saveItems()
    }
    
    func loadItems() {
        if FileManager.default.fileExists(atPath: self.itemsPath) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.itemsPath)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                self.MeetingCountByCustmoer = unarchiver.decodeObject(forKey: "MeetingCountByCustmoerId") as! [MeetingCountByCustmoerIdclass]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func saveItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self.MeetingCountByCustmoer, forKey: "MeetingCountByCustmoerId")
        archiver.finishEncoding()
        data.write(toFile: self.itemsPath, atomically: true)
    }
    
    func removeAllItems() {
        self.MeetingCountByCustmoer.removeAll()
        self.saveItems()
    }
    
}

