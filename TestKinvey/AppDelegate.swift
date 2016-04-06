//
//  AppDelegate.swift
//  TestKinvey
//
//  Created by Santosh Surve on 3/30/16.
//  Copyright © 2016 mindscrub. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //[[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]]
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings.init(forTypes: [.Alert, .Badge, .Sound],categories: nil))
            
        UIApplication.sharedApplication().registerForRemoteNotifications()
       
        
        KCSClient.sharedClient().initializeKinveyServiceForAppKey(
            "kid_-Jii9oHxC",
            withAppSecret: "a8ada55a94d741ca8f36356c57452763",
            usingOptions: nil
        )
        
        KCSPush.registerForPush()
        
        KCSPing.pingKinveyWithBlock { (result: KCSPingResult!) -> Void in
            if result.pingWasSuccessful {
                NSLog("Kinvey Ping Success")
               // KCSPush.sharedPush().setPushBadgeNumber(100)
            } else {
                NSLog("Kinvey Ping Failed")
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

//    func applicationDidBecomeActive(application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }
//
//    func applicationWillTerminate(application: UIApplication) {
//        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        KCSPush.sharedPush().application(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken,
            completionBlock: { (success: Bool, error: NSError!) -> Void in
                //if there is an error, try again later
            }
        )
        // Additional registration goes here (if needed)
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        KCSPush.sharedPush().application(application, didReceiveRemoteNotification: userInfo)
        // Additional push notification handling code should be performed here
    }
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        KCSPush.sharedPush().application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    func applicationDidBecomeActive(application: UIApplication) {
        KCSPush.sharedPush().registerForRemoteNotifications()
        //Additional become active actions
    }
    func applicationWillTerminate(application: UIApplication) {
        KCSPush.sharedPush().onUnloadHelper()
        // Additional termination actions
    }


}

