//
//  FilterByRateVc.swift
//  Handsy
//
//  Created by M on 9/27/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

class FilterByRateVc: UIViewController {
    var barBtnDelegate: BarBtnDelegate?
    var barBtnMapDelegate: BarBtnMapDelegate?
    var AllSelectArr:[Character] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if(rateSelected != "")
        {
           
             AllSelectArr = Array( rateSelected.replacingOccurrences(of: ",", with: ""))
            for item in AllSelectArr
            {
                if (item == "1")
                {
                    select1.isHidden = false
                     r1 = "1,"
                }else if(item == "2"){
                     r2 = "2,"
                      select2.isHidden = false
                }else if(item == "3"){
                     r3 = "3,"
                      Select3.isHidden = false
                }else if(item == "4"){
                    sekect4.isHidden = false
                     r4 = "4,"
                }else if(item == "0"){
                    select0.isHidden = false
                     r0 = "0,"
                }
                else{
                    Select5.isHidden = false
                     r5 = "5,"
                }
            }
            
        }
        
    }
    
    @IBOutlet weak var select0: UIButton!
    @IBOutlet weak var select1: UIButton!
    @IBOutlet weak var select2: UIButton!
    @IBOutlet weak var Select3: UIButton!
    @IBOutlet weak var sekect4: UIButton!
    @IBOutlet weak var Select5: UIButton!
    @IBOutlet weak var SendRate: UIButton!
    var Expsort = ""
    var AllRate = ""
    var CompanyName = ""
    var rateSelected = ""
    
    var r0 = ""
    var r1 = ""
    var r2 = ""
    var r3 = ""
    var r4 = ""
    var r5 = ""
    var ArryRatr:[String] = []
    @IBAction func Select5Btn(_ sender: Any) {
        if(Select5.isHidden == true)
        {
            Select5.isHidden = false
            r5 = "5,"
        }else
        {
            Select5.isHidden = true
            r5 = ""
        }
    }
    
    
    @IBAction func Select4Btn(_ sender: Any) {
        
        if(sekect4.isHidden == true)
        {
            r4 = "4,"
            sekect4.isHidden = false
            
        }else
        {
            sekect4.isHidden = true
            r4 = ""
        }
    }
    @IBAction func Select3Btn(_ sender: Any) {
        
        if(Select3.isHidden == true)
        {
            Select3.isHidden = false
            r3 = "3,"
        }else
        {
            Select3.isHidden = true
            r3 = ""
        }
        
    }
    
    @IBAction func select2btn(_ sender: Any) {
        
        if(select2.isHidden == true)
        {
            select2.isHidden = false
            r2 = "2,"
        }else
        {
            select2.isHidden = true
            r2 = ""
        }
    }
    @IBAction func select1btn(_ sender: Any) {
        
        if(select1.isHidden == true)
        {
            r1 = "1,"
            select1.isHidden = false
        }else
        {
            select1.isHidden = true
            r1 = ""
        }
    }
    @IBAction func select0btn(_ sender: Any) {
        
        if(select0.isHidden == true)
        {
            select0.isHidden = false
            r0 = "0,"
        }else
        {
            select0.isHidden = true
            r0 = ""
        }
    }
    @IBAction func Dismis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func SendSelectRate(_ sender: Any) {
        ArryRatr.append(r0)
        ArryRatr.append(r1)
        ArryRatr.append(r2)
        ArryRatr.append(r3)
        ArryRatr.append(r4)
        ArryRatr.append(r5)
        
        for item in ArryRatr
        {
            if (item != "")
            {
                AllRate += item
            }
        }
        if(AllRate != "")
        {
            AllRate.remove(at: AllRate.index(before: AllRate.endIndex))
        }
        print(AllRate)
        print(Expsort)
        
          if self.barBtnDelegate == nil {
        self.barBtnMapDelegate?.BarBtnSortExpDidChange(SortExp: Expsort, companyTypeName: CompanyName, RateNumber: AllRate)
        
        }
          else{
            self.barBtnDelegate?.BarBtnSortExpDidChange(SortExp: Expsort, companyTypeName: CompanyName ,Rate: AllRate)
            
        }
        
        self.dismiss(animated: false, completion: nil)
    }
}
