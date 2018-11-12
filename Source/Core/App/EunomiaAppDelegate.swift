//
//  EunomiaAppDelegate.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/23/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

import UIKit

open class EunomiaAppDelegate: UIResponder, UIApplicationDelegate {
    open var window: UIWindow?
    
    open func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        do {
            try DDLog.setupLogger(consoleLogLevel: DDLogLevel.debug)
        } catch {
            NSLog("Error: while settings up logging: \(error)")
        }

        UIApplication.dumpApplicationInformation()
        
        return true
    }
    
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    open func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    open func applicationWillResignActive(_ application: UIApplication) {
        
    }

    open func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return false
    }
    
    open func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return false
    }
    
    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        
    }
    
    open func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    open func applicationSignificantTimeChange(_ application: UIApplication) {
        
    }
    
    open func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        
    }
    
    open func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        
    }
    
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    open func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
}
