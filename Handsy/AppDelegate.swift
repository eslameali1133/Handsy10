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
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    
    var window: UIWindow?
    // A constant to hold your Google iOS API key. Replace YOUR_GOOGLE_IOS_API_KEY with the Google iOS API key you created earlier.
    let googleMapsApiKey = "AIzaSyBIoI3T5929aAQVlIDsW5XsGzir5BjRfqo"
    
    let badgeCount: Int = 0
    let applicationl = UIApplication.shared
    var isGrantedNotificationAccess:Bool = true
    let userDefaults = UserDefaults.standard
    var currentTimesOfOpenApp:Int = 0
    var optionallyStoreTheFirstLaunchFlag = false
    var anothoerroom = false
    
    func saveTimesOfOpenApp() -> Void {
        userDefaults.set(currentTimesOfOpenApp, forKey: "timesOfOpenApp")
    }
    
    func getCurrentTimesOfOpenApp() -> Int {
        return userDefaults.integer(forKey: "timesOfOpenApp") + 1
    }
    
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
        print("udidKey: \(udidKey)")
        
        if let userInfo = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
            let storyboard:UIStoryboard = UIStoryboard(name: "NewHome", bundle: nil)
            let navigationController = storyboard.instantiateViewController(withIdentifier: "NewMain") as! UITabBarController
            navigationController.selectedIndex = 0
            self.window?.rootViewController = navigationController
        }
        
        
        
        
        
        
        self.currentTimesOfOpenApp = getCurrentTimesOfOpenApp()
        optionallyStoreTheFirstLaunchFlag = UserDefaults.isFirstLaunch()
        
        //        let center =  UNUserNotificationCenter.current()
        //        center.requestAuthorization(options: [.alert, .sound, .badge]) { (result, error) in
        //            //handle result of request failure
        //            print(result)
        //        }
        //        contentPush(title: " Jurassic Park", body: "Its lunch time at the park, please join us for a dinosaur feeding")
        return true
    }
    
    func contentPush(title: String, body: String, userInfo: [AnyHashable: Any]) {
        //get the notification center
        let center =  UNUserNotificationCenter.current()
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = title
        //        content.subtitle = subtitle
        content.body = body
        content.userInfo = userInfo
        content.sound = UNNotificationSound.default()
        
        //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:2.0, repeats: false)
        
        //create request to display
        let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
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
        saveTimesOfOpenApp()
        
    }
    
    
    
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    
    //    func userNotificationCenter(_ center: UNUserNotificationCenter,
    //                                didReceive response: UNNotificationResponse,
    //                                withCompletionHandler completionHandler: @escaping () -> Void){
    //
    //    }
    
    
    func MarkNotifyReadByNotifyID(NotificationID: String) {
        let parameters: Parameters = [
            "NotificationID": NotificationID
        ]
        Alamofire.request("http://smusers.promit2030.co/Service1.svc/MarkNotifyReadByNotifyID", method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
            
        }
    }
    
    func ReadAllMessageForCust(ProjectId: String) {
        Alamofire.request("http://smusers.promit2030.co/api/ApiService/ReadAllMessageForCust?ProjectId=\(ProjectId)", method: .post, encoding: URLEncoding.default).responseJSON { response in
            debugPrint(response)
        }
    }
    
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    //
    //        let userInfo:[AnyHashable:Any] =  notification.request.content.userInfo
    //        let state : UIApplicationState = applicationl.applicationState
    //
    //        switch state {
    //        case UIApplicationState.inactive:
    //            print("123")
    //        default:
    //            print("Run code to download content")
    //            completionHandler([.alert,.badge,.sound])
    //        }
    //
    //        // Print full message.
    //        print(userInfo)
    //    }
    
    
    
    
    
    func movetoHoem()
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "NewHome", bundle:nil)
        let sub = storyBoard.instantiateViewController(withIdentifier: "NewMain") as! NewTabBarViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = sub
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let aps = userInfo["aps"] as? NSDictionary {
            let alert = aps["alert"] as? NSDictionary
            let title = alert?["title"] as? String
            let body = alert?["body"] as? String
            
        }
        
        
        print(userInfo)
        
        if let messageID = userInfo["PushType"]{
            print("Message ID: \(messageID)")
            let type = userInfo["PushType"] as? String
            print("type: \(type)")
            let notificationID = userInfo["NotificationID"] as? String
            comingnotification = true
            trypNotification = type!
            if type == "1" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                ProIDGloable = (userInfo["ProjectId"] as? String)!
                movetoHoem()
                
            }else if type == "2"{
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
              guard let MeetingId = userInfo["MeetingID"] as? String else {
                    comingnotification = false
                    movetoHoem()
                    return
                }
                MeetingID = MeetingId
                movetoHoem()
                
                
            }else if type == "3" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                ProIDGloable = (userInfo["ProjectId"] as? String)!
                movetoHoem()
                
            }else if type == "4" {
                
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                ProIDGloable = (userInfo["ProjectId"] as? String)!
                movetoHoem()
                
            }else if type == "5" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
             guard  let DesignStagesID = userInfo["DesignStagesID"] as? String else {
                    comingnotification = false
                    movetoHoem()
                    return
                }
                designStagesID = DesignStagesID
                
                movetoHoem()
                
            }else if type == "7" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
               guard let DesignStagesID = userInfo["DesignStagesID"] as? String else {
                    comingnotification = false
                    movetoHoem()
                    return
                }
                designStagesID = DesignStagesID
                movetoHoem()
                
                
                
            }else if type == "6" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                guard let DesignStagesID = userInfo["DesignStagesID"] as? String else {
                    comingnotification = false
                    movetoHoem()
                    return
                }
                designStagesID = DesignStagesID
                movetoHoem()
                
                
                
            }
            else if type == "8" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                Filegl = (userInfo["File"] as? String)!
                ProIDGloable = (userInfo["ProjectId"] as? String)!
                movetoHoem()
                
                
            }
            else if type == "10" {
                MarkNotifyReadByNotifyID(NotificationID: notificationID!)
                   ProIDGloable = (userInfo["ProjectId"] as? String)!
                movetoHoem()
                
                
            }
            else if type == "9" {
                let ProjectId = userInfo["ProjectId"] as? String
                ProIDGloable = (userInfo["ProjectId"] as? String)!
                ReadAllMessageForCust(ProjectId: ProjectId!)
              if anothoerroom == true
                {
                    anothoerroom = false
                      movetoHoem()
                }
                else
              {
                if let VC = UIApplication.topViewController() as? ChatOfProjectsViewController {
                    let messageByProjectIdObj = MessageByProjectId()
                    messageByProjectIdObj.ImageName = userInfo["ImageName"] as? String
                    messageByProjectIdObj.ImagePath = userInfo["ImagePath"] as? String
                    messageByProjectIdObj.Message = userInfo["Message"] as? String
                    messageByProjectIdObj.MessageTime = userInfo["MessageTime"] as? String
                    messageByProjectIdObj.MessageType = userInfo["MessageType"] as? String
                    messageByProjectIdObj.SenderId = userInfo["SenderId"] as? String
                    messageByProjectIdObj.SenderImage = userInfo["SenderImage"] as? String
                    messageByProjectIdObj.SenderName = userInfo["SenderName"] as? String
                    messageByProjectIdObj.SenderType = userInfo["SenderType"] as? String
                    messageByProjectIdObj.Lat = userInfo["Lat"] as? String
                    messageByProjectIdObj.Lng = userInfo["Lng"] as? String
                    messageByProjectIdObjgl = messageByProjectIdObj
                    VC.messagesList.append(messageByProjectIdObj)
                    VC.scrollToBottom()
                    VC.chatTableView.reloadData()
                   
                }else {
                    
                    movetoHoem()
                }
                }
            }else {
                 comingnotification = false
                 movetoHoem()
                
             
            }
            
        }
        
        // Print full message.
        print(userInfo)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
        let userInfo:[AnyHashable:Any] =  notification.request.content.userInfo
        let state : UIApplicationState = applicationl.applicationState
        var type = ""
        if let messageID = userInfo["PushType"]{
            print("Message ID: \(messageID)")
            type = (userInfo["PushType"] as? String)!
        }
        print(userInfo)
          let ProjectId = userInfo["ProjectId"] as? String
        
     
         if type == "9" {
            if(ProjectId == chatRoomProjectId)
            {
                
                switch state {
                case UIApplicationState.active:
                    print("If needed notify user about the message")
                    if let messageID = userInfo["PushType"]{
                        print("Message ID: \(messageID)")
                        let type = userInfo["PushType"] as? String
                        print("type: \(type)")
                        let notificationID = userInfo["NotificationID"] as? String
                        if type == "9" {
                            let ProjectId = userInfo["ProjectId"] as? String
                            if let VC = UIApplication.topViewController() as? ChatOfProjectsViewController {
                                ReadAllMessageForCust(ProjectId: ProjectId!)
                                let messageByProjectIdObj = MessageByProjectId()
                                messageByProjectIdObj.ImageName = userInfo["ImageName"] as? String
                                messageByProjectIdObj.ImagePath = userInfo["ImagePath"] as? String
                                messageByProjectIdObj.Message = userInfo["Message"] as? String
                                messageByProjectIdObj.MessageTime = userInfo["MessageTime"] as? String
                                messageByProjectIdObj.MessageType = userInfo["MessageType"] as? String
                                messageByProjectIdObj.SenderId = userInfo["SenderId"] as? String
                                messageByProjectIdObj.SenderImage = userInfo["SenderImage"] as? String
                                messageByProjectIdObj.SenderName = userInfo["SenderName"] as? String
                                messageByProjectIdObj.SenderType = userInfo["SenderType"] as? String
                                messageByProjectIdObj.Lat = userInfo["Lat"] as? String
                                messageByProjectIdObj.Lng = userInfo["Lng"] as? String
                                VC.messagesList.append(messageByProjectIdObj)
                                VC.scrollToBottom()
                                VC.chatTableView.reloadData()
                                completionHandler([])
                            }else {
                                completionHandler([.alert,.badge])
                            }
                        }
                    }else {
                        completionHandler([.alert,.badge])
                    }
                    
                default:
                    print("Run code to download content")
                    completionHandler([.alert,.badge,.sound])
                }
            }
                // not same project
            else
            {
                anothoerroom = true
                chatRoomProjectId = ProjectId!
                completionHandler(.alert)
                
            }
            
        }
        else{
            completionHandler([.alert,.badge])
        }
        
        
        
   
        }
}
extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
