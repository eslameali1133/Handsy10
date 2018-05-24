//
//  TAMapCircle.swift
//  
//
//  Created by Ahmed Wahdan on 12/13/17.
//

import UIKit

class TAMapCircle: GMSCircle {
    var handler: (() -> Void)? = nil
    var begin: Date?
    
    var from = CLLocationDistance()
    var to = CLLocationDistance()
    var duration: TimeInterval = 0.0
    
    // just call this
    
    func beginRadiusAnimation(from: CLLocationDistance, to: CLLocationDistance, duration: TimeInterval, completeHandler: @escaping () -> Void) {
        handler = completeHandler
        begin = Date()
        self.from = from
        self.to = to
        self.duration = duration
        performSelector(onMainThread: #selector(self.updateSelf), with: nil, waitUntilDone: false)
    }
    
    // internal update
    @objc func updateSelf() {
        let i: TimeInterval = Date().timeIntervalSince(begin!)
        if i >= duration {
            radius = to
            handler!()
            return
        }
        else {
            let d = ((to - from) * i / duration + from) as? CLLocationDistance
            radius = d!
            // do it again at next run loop
            performSelector(onMainThread: #selector(self.updateSelf), with: nil, waitUntilDone: false)
        }
    }
}
