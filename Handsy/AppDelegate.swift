//
//  AppDelegate.swift
//  Handsy
//
//  Created by Ahmed Wahdan on 7/20/17.
//  Copyright © 2017 Ahmed Wahdan. All rights reserved.
//

import UIKit
import UserNotifications
import LocalAuthentication
import GooglePlaces
import Alamofire
import SwiftyJSON
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    
    var window: UIWindow?
    // A constant to hold your Google iOS API key. Replace YOUR_GOOGLE_IOS_API_KEY with the Google iOS API key you created earlier.
    let googleMapsApiKey = "AIzaSyBIoI3T5929aAQVlIDsW5XsGzir5BjRfqo"
    
    let badgeCount: Int = 0
    let applicationl = UIApplication.shared
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2117647059, alpha: 1)
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03921568627, alpha: 1)
UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 10) ], for: .normal)
        GMSServices.provideAPIKey(googleMapsApiKey)
        GMSPlacesClient.provideAPIKey(googleMapsApiKey)
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        }else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        UserDefaults.standard.set(token, forKey: "token")
        let udidKey = UIDevice.current.identifierForVendor!.uuidString
        UserDefaults.standard.set(udidKey, forKey: "udidKey")
        
        if let userInfo = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
            let storyboard:UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
            let navigationController = storyboard.instantiateViewController(withIdentifier: "NewMain") as! UITabBarController
            navigationController.selectedIndex = 0
            self.window?.rootViewController = navigationController
        }
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "token")
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    
    //    func userNotificationCenter(_ center: UNUserNotificationCenter,
    //                                didReceive response: UNNotificationResponse,
    //                                withCompletionHandler completionHandler: @escaping () -> Void){
    //        self.applicationl.applicationIconBadgeNumber = badgeCount + 1
    //    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        self.applicationl.applicationIconBadgeNumber = badgeCount + 1
        // Print message ID.
        if let messageID = userInfo["message"]{
            print("Message ID: \(messageID)")
            let type = userInfo["Type"] as? String
            let notificationID = userInfo["NotificationID"] as? String
            print("type: \(type)")
            var titleAlert = ""
            var bodyAlert = ""
            if let aps = userInfo["aps"] as? NSDictionary {
                let alert = aps["alert"] as? NSDictionary
                let title = alert?["title"] as? String
                let body = alert?["body"] as? String
                titleAlert = title!
                bodyAlert = body!
            }
            if type == "1" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let ProjectId = userInfo["ProjectId"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
                secondView.ProjectId = ProjectId!
                secondView.nou = "LOl"
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "2" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let MeetingId = userInfo["MeetingId"] as? String
                MeetingID = MeetingId!
                let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsDetialsTableViewController") as! VisitsDetialsTableViewController
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "3" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let ProjectId = userInfo["ProjectId"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
                secondView.ProjectId = ProjectId!
                secondView.nou = "LOl"
                
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "4" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let ProjectId = userInfo["ProjectId"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "MoneyManagmentDetialsTableViewController") as! MoneyManagmentDetialsTableViewController
                secondView.ProjectId = ProjectId!
                secondView.pushCond = "LOl"
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "5" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let DesignStagesID = userInfo["DesignStagesID"] as? String
                designStagesID = DesignStagesID!
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "7" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let DesignStagesID = userInfo["DesignStagesID"] as? String
                designStagesID = DesignStagesID!
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
                secondView.isScroll = true
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "8" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let File = userInfo["File"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "ShowContractViewController") as! ShowContractViewController
                secondView.url = File!
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else {
                print("type: \(type)")
            }
            
        }
        
        // Print full message.
        print(userInfo)
    }
    func MarkNotifyReadByNotifyID(NotificationID: String) {
        let parameters: Parameters = [
            "NotificationID": NotificationID
        ]
        Alamofire.request("http://smusers.promit2030.com/Service1.svc/MarkNotifyReadByNotifyID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        self.applicationl.applicationIconBadgeNumber = badgeCount + 1
        // Print message ID.
        if let messageID = userInfo["message"]{
            print("Message ID: \(messageID)")
            let type = userInfo["Type"] as? String
            print("type: \(type)")
            let notificationID = userInfo["NotificationID"] as? String
            var titleAlert = ""
            var bodyAlert = ""
            if let aps = userInfo["aps"] as? NSDictionary {
                let alert = aps["alert"] as? NSDictionary
                let title = alert?["title"] as? String
                let body = alert?["body"] as? String
                titleAlert = title!
                bodyAlert = body!
            }
            if type == "1" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let ProjectId = userInfo["ProjectId"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
                secondView.ProjectId = ProjectId!
                secondView.nou = "LOl"
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = self.badgeCount - 1
            }else if type == "2" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let MeetingId = userInfo["MeetingId"] as? String
                MeetingID = MeetingId!
                let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsDetialsTableViewController") as! VisitsDetialsTableViewController
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = self.badgeCount - 1
            }else if type == "3" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let ProjectId = userInfo["ProjectId"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
                secondView.ProjectId = ProjectId!
                secondView.nou = "LOl"
                
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = self.badgeCount - 1
            }else if type == "4" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let ProjectId = userInfo["ProjectId"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "MoneyManagmentDetialsTableViewController") as! MoneyManagmentDetialsTableViewController
                secondView.ProjectId = ProjectId!
                secondView.pushCond = "LOl"
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = self.badgeCount - 1
            }else if type == "5" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let DesignStagesID = userInfo["DesignStagesID"] as? String
                designStagesID = DesignStagesID!
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = self.badgeCount - 1
            }else if type == "7" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let DesignStagesID = userInfo["DesignStagesID"] as? String
                designStagesID = DesignStagesID!
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
                secondView.isScroll = true
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = self.badgeCount - 1
            }else if type == "8" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let File = userInfo["File"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "ShowContractViewController") as! ShowContractViewController
                secondView.url = File!
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else {
                print("type: \(type)")
            }
            
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Change this to your preferred presentation option
        completionHandler([.alert,.badge,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo["message"]{
            print("Message ID: \(messageID)")
            let type = userInfo["Type"] as? String
            print("type: \(type)")
            let notificationID = userInfo["NotificationID"] as? String
            var titleAlert = ""
            var bodyAlert = ""
            if let aps = userInfo["aps"] as? NSDictionary {
                let alert = aps["alert"] as? NSDictionary
                let title = alert?["title"] as? String
                let body = alert?["body"] as? String
                titleAlert = title!
                bodyAlert = body!
            }
            if type == "1" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let ProjectId = userInfo["ProjectId"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
                secondView.ProjectId = ProjectId!
                secondView.nou = "LOl"
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "2" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let MeetingId = userInfo["MeetingId"] as? String
                MeetingID = MeetingId!
                let storyBoard : UIStoryboard = UIStoryboard(name: "VisitsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "VisitsDetialsTableViewController") as! VisitsDetialsTableViewController
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "3" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let ProjectId = userInfo["ProjectId"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "NewProjectDetialsFilterTableViewController") as! NewProjectDetialsFilterTableViewController
                secondView.ProjectId = ProjectId!
                secondView.nou = "LOl"
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "4" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let ProjectId = userInfo["ProjectId"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "MoneyManagmentDetialsTableViewController") as! MoneyManagmentDetialsTableViewController
                secondView.ProjectId = ProjectId!
                secondView.pushCond = "LOl"
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "5" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let DesignStagesID = userInfo["DesignStagesID"] as? String
                designStagesID = DesignStagesID!
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "7" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let DesignStagesID = userInfo["DesignStagesID"] as? String
                designStagesID = DesignStagesID!
                let storyBoard : UIStoryboard = UIStoryboard(name: "DesignsAndDetails", bundle: nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "DetailsDesignTableViewController") as! DetailsDesignTableViewController
                secondView.isScroll = true
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else if type == "8" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                let File = userInfo["File"] as? String
                let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectsAndEdit", bundle:nil)
                let secondView = storyBoard.instantiateViewController(withIdentifier: "ShowContractViewController") as! ShowContractViewController
                secondView.url = File!
                let topController = UIApplication.topViewController()
                topController?.show(secondView, sender: true)
                self.applicationl.applicationIconBadgeNumber = badgeCount - 1
            }else {
                print("type: \(type)")
            }
            
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }

}
