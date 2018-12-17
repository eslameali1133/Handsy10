//
//  EditRecoredModel.swift
//  Handsy
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class EditRecoredModel: NSObject {
    
    var CreateDate: String = ""
    var UserId: String = ""
    var File: String = ""
    var Details: String = ""
    var ActionID: String = ""
    var DesignStagesID: String = ""
    var DesignStagesLogGUID: String = ""
    var DesignStagesLogID: String = ""
     init(CreateDate: String, UserId: String, File: String, Details: String, ActionID: String, DesignStagesID: String, DesignStagesLogGUID: String, DesignStagesLogID: String) {
        self.CreateDate = CreateDate
         self.UserId = UserId
         self.File = File
         self.Details = Details
         self.ActionID = ActionID
         self.DesignStagesID = DesignStagesID
         self.DesignStagesLogGUID = DesignStagesLogGUID
         self.DesignStagesLogID = DesignStagesLogID
        
        
    }
    
}


class EditRecoredContractModel: NSObject {
    
    var ContractHistoryID: String = ""
    var ContractHistoryGUID: String = ""
    var ProjectId: String = ""
    var UserId: String = ""
    var ContractHistoryTitle: String = ""
    var ContractHistoryPath: String = ""
    var ContractHistoryNote: String = ""
    var ContractHistoryStatus: String = ""
      var ContractHistoryDate: String = ""
    init(ContractHistoryID: String, ContractHistoryGUID: String, ProjectId: String, UserId: String, ContractHistoryTitle: String, ContractHistoryPath: String, ContractHistoryNote: String, ContractHistoryStatus: String,ContractHistoryDate: String) {
        self.ContractHistoryID = ContractHistoryID
        self.ContractHistoryGUID = ContractHistoryGUID
        self.ProjectId = ProjectId
        self.UserId = UserId
        self.ContractHistoryTitle = ContractHistoryTitle
        self.ContractHistoryPath = ContractHistoryPath
        self.ContractHistoryNote = ContractHistoryNote
        self.ContractHistoryStatus = ContractHistoryStatus
        self.ContractHistoryDate = ContractHistoryDate
        
        
    }
    
}
