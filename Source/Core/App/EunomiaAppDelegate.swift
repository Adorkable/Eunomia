//
//  EunomiaAppDelegate.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/23/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

import UIKit

import CocoaLumberjack

public class EunomiaAppDelegate: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    
    public func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        DDLog.setupLogger(DDLogLevel.Debug)
        
        UIApplication.dumpApplicationInformation()
        
        return true
    }
    
    public func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        return true
    }
    
    public func applicationDidBecomeActive(application: UIApplication) {
        
    }
    
    public func applicationWillResignActive(application: UIApplication) {
        
    }

    public func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return false
    }
    
    public func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return false
    }
    
    public func applicationDidReceiveMemoryWarning(application: UIApplication) {
        
    }
    
    public func applicationWillTerminate(application: UIApplication) {
        
    }
    
    public func applicationSignificantTimeChange(application: UIApplication) {
        
    }
    
    public func application(application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
    }
    
    public func application(application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        
    }
    
    public func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
    }
    
    public func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
    }
    
    public func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
    }
    
    public func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
    }
    
    public func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
    }
    
    public func applicationDidEnterBackground(application: UIApplication) {
        
    }
    
    public func applicationWillEnterForeground(application: UIApplication) {
        
    }
}
