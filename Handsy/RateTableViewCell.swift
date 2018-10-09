//
//  RateTableViewCell.swift
//  Handsy
//
//  Created by M on 9/26/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit
protocol GetRateValue: class {
    func getRateValue(info: String , Index: Int)
}

class RateTableViewCell: UITableViewCell {
 var delegate : GetRateValue?
    @IBOutlet weak var lbl_Question: UILabel!
    
    @IBOutlet weak var RateView: FloatRatingView!
    var rateArry:[String] = []
 var index = 0
   
    
    override func awakeFromNib() {
        RateView.delegate = self
        RateView.contentMode = UIViewContentMode.scaleAspectFit
        RateView.type = .wholeRatings
        super.awakeFromNib()
      
    }
    
    
  
   
}
extension RateTableViewCell: FloatRatingViewDelegate {
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        let value = String(format: "%.2f", self.RateView.rating)
        print(index)
//        if(rateArry.count > 0)
//        {
//        rateArry.remove(at: index)
//        }
//        rateArry.insert(value, at: index)
        if delegate != nil {
            delegate?.getRateValue(info: value , Index: index )
        }
      
    }
    
}
