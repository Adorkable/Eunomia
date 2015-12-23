//
//  UIApplication+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/24/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import UIKit

import CocoaLumberjack

extension UIApplication
{
    public class func dumpApplicationInformation() {
        if let applicationVersion = self.applicationVersion
        {
            DDLog.info("Application Version: \(applicationVersion)")
        }
        if let buildVersion = self.buildVersion
        {
            DDLog.info("Build Version: \(buildVersion)")
        }
        
        if UIDevice.currentDevice().isSimulator
        {
            DDLog.info("Simulator build running from bundle: \(NSBundle.mainBundle().bundleURL)")
            if let documentPath = getAppDocumentPath()
            {
                DDLog.info("Document folder: \(documentPath)")
            }
            if let appLibraryPath = getAppLibraryPath()
            {
                DDLog.info("Library folder: \(appLibraryPath)")
            }
        }
    }
    
    public static var applicationVersion : String? {
        var result : String?
        
        if let info = NSBundle.mainBundle().infoDictionary
        {
            result = info["CFBundleShortVersionString"] as? String
        }
        
        return result
    }
    
    public static var buildVersion : String? {
        var result : String?
        
        if let info = NSBundle.mainBundle().infoDictionary
        {
            result = info["CFBundleVersion"] as? String
        }
        
        return result
    }
    
    public class func applicationAndBuildVersion() -> String {
        return "\(self.applicationVersion)_\(self.buildVersion)"
    }
}

extension UIApplication {
    
    public func mailTo(emailAddress : String,
        subject : String,
        body : String? = nil) throws {
            
            var parameters = [
                "mailto:\(emailAddress)",
                "subject=\(subject)"
            ]
            if let body = body {
                parameters.append("body=\(body)")
            }
            
            guard let path = (parameters as NSArray).componentsJoinedByString("&").stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) else {
                throw NSError(description: "Unable to create path String with parameters \(parameters)")
            }
            
            guard let url = NSURL(string: path) else {
                throw NSError(description: "Unable to create NSURL with path \(path)")
            }
            
            self.openURL(url)
    }
}