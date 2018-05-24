//
//  Constants.swift
//  Handsy
//
//  Created by Mahmoud Yousef on 4/10/17.
//  Copyright (c) 2017 Haseboty. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    struct fontNames {
        static let mainFont = "A Jannat LT"
    }
    
    struct colors {
        static let primary = Constants.colors.color(code: 0x282828)
        static let primaryDark = Constants.colors.color(code: 0x171717)
        static let darkYellow = Constants.colors.color(code: 0xd4af36)
        static let hint = Constants.colors.color(code: 0x6b6b6b)
        static let error = Constants.colors.color(code: 0xe74c3c)
        
        static func color(code: Int) -> UIColor {            
            var red = CGFloat((code & 0xFF0000) >> 16) / 255.0
            var green = CGFloat((code & 0x00FF00) >> 8) / 255.0
            var blue = CGFloat(code & 0x0000FF) / 255.0
            
            return UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
    }
    
    struct connection {
        /*static let db = SQLClient.sharedInstance()
        static let host = "188.121.44.214"
        static let username = "A_Elsenoesy"
        static let password = "A_Elsenoesy"
        static let database = "A_Elsenoesy"
        static let owner = "dbo"*/
        static let url = "http://smusers.i-tecgroup.com/Service1.svc/"
        static let warning = "لا يوجد اتصال بالانترنت"
    }
    
    private struct alertReciever {
        static var reciever: UIViewController?
    }
    
    class func alert(message: NSString, type: Int, reciever: UIViewController) -> UIAlertController {
        alertReciever.reciever = reciever
        
        var alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        (alert.view.subviews[0] as UIView).isHidden = true
        
        var mainView = UIView(frame: CGRect(x: -1.0 / 2.0 * alert.view.frame.width, y: -1.0 / 2.0 * alert.view.frame.height, width: alert.view.frame.width, height: alert.view.frame.height))
            
        mainView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        alert.view.addSubview(mainView)
        
        var alertView = UIView(frame: CGRect(x: 1.0 / 10.0 * mainView.frame.width, y: 2.0 / 5.0 * mainView.frame.height, width: 8.0 / 10.0 * mainView.frame.width, height: 1.0 / 5.0 * mainView.frame.height))
        alertView.backgroundColor = colors.primaryDark
        mainView.addSubview(alertView)
        
        let title = UILabel(frame: CGRect(x: 1.0 / 10.0 * alertView.frame.width, y: 1.0 / 10.0 * alertView.frame.height, width: 8.0 / 10.0 * alertView.frame.width, height: 0.9 / 2.0 * alertView.frame.height))
        title.text = message as String
        title.textAlignment = NSTextAlignment.center
        title.textColor = UIColor.white
        title.font = UIFont(name: fontNames.mainFont, size: 1.0 / 22.0 * mainView.frame.width)
        title.numberOfLines = 2
        alertView.addSubview(title)
        
        if type == 1 {
            let ok = UIButton(frame: CGRect(x: 0, y: 2.0 / 3.0 * alertView.frame.height, width: alertView.frame.width, height: 1.0 / 3.0 * alertView.frame.height))
            ok.tag = 1
            ok.backgroundColor = colors.darkYellow
            ok.setTitle("إنهاء", for: UIControlState.normal)
            ok.setTitleColor(UIColor.white, for: UIControlState.normal)
            ok.titleLabel?.font = UIFont(name: fontNames.mainFont, size: 1.0 / 22.0 * mainView.frame.width)
            ok.addTarget(self, action: Selector(("alertAction:")), for: UIControlEvents.touchUpInside)
            alertView.addSubview(ok)
        } else {
            let yes = UIButton(frame: CGRect(x: 0, y: 2.0 / 3.0 * alertView.frame.height, width: 1.0 / 2.0 * alertView.frame.width - 1, height: 1.0 / 3.0 * alertView.frame.height))
            yes.tag = 2
            yes.backgroundColor = colors.darkYellow
            yes.setTitle("نعم", for: UIControlState.normal)
            yes.setTitleColor(UIColor.white, for: UIControlState.normal)
            yes.titleLabel?.font = UIFont(name: fontNames.mainFont, size: 1.0 / 22.0 * mainView.frame.width)
            yes.addTarget(self, action: Selector(("alertAction:")), for: UIControlEvents.touchUpInside)
            alertView.addSubview(yes)
            
            var no = UIButton(frame: CGRect(x: 1.0 / 2.0 * alertView.frame.width + 1, y: 2.0 / 3.0 * alertView.frame.height, width: 1.0 / 2.0 * alertView.frame.width - 1, height: 1.0 / 3.0 * alertView.frame.height))
            no.tag = 3
            no.backgroundColor = colors.darkYellow
            no.setTitle("لا", for: UIControlState.normal)
            no.setTitleColor(UIColor.white, for: UIControlState.normal
            
            )
            no.titleLabel?.font = UIFont(name: fontNames.mainFont, size: 1.0 / 22.0 * mainView.frame.width)
            no.addTarget(self, action: Selector(("alertAction:")), for: UIControlEvents.touchUpInside)
            alertView.addSubview(no)
        }
        
        /*alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            println("ok")
        }))*/
        
        return alert
    }
    
   
    private func alertAction(sender: UIButton) {
        let selected = sender.tag
        
        print("yes no ok")
        
        if selected == 2 {
            
        } else {
            alertReciever.reciever?.dismiss(animated: true, completion: nil)
        }
    }
}
