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
            DDLog.info(message: "Application Version: \(applicationVersion)")
        }
        if let buildVersion = self.buildVersion
        {
            DDLog.info(message: "Build Version: \(buildVersion)")
        }
        
        if UIDevice.current.isSimulator
        {
            DDLog.info(message: "Simulator build running from bundle: \(Bundle.main.bundleURL)")
            if let documentPath = getAppDocumentPath()
            {
                DDLog.info(message: "Document folder: \(documentPath)")
            }
            if let appLibraryPath = getAppLibraryPath()
            {
                DDLog.info(message: "Library folder: \(appLibraryPath)")
            }
        } else {
            DDLog.info(message: "Device build")
        }
    }
    
    public static var applicationVersion : String? {
        var result : String?
        
        if let info = Bundle.main.infoDictionary
        {
            result = info["CFBundleShortVersionString"] as? String
        }
        
        return result
    }
    
    public static var buildVersion : String? {
        var result : String?
        
        if let info = Bundle.main.infoDictionary
        {
            result = info["CFBundleVersion"] as? String
        }
        
        return result
    }
    
    public class func applicationAndBuildVersion() -> String {
        return "\(String(describing: self.applicationVersion))_\(String(describing: self.buildVersion))"
    }
}

extension UIApplication {
    
    public func mailTo(_ emailAddress : String,
        subject : String,
        body : String? = nil) throws {
            
            var parameters = [
                "mailto:\(emailAddress)",
                "subject=\(subject)"
            ]
            if let body = body {
                parameters.append("body=\(body)")
            }
            
            guard let path = (parameters as NSArray).componentsJoined(by: "&").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                throw NSError(description: "Unable to create path String with parameters \(parameters)")
            }
            
            guard let url = URL(string: path) else {
                throw NSError(description: "Unable to create NSURL with path \(path)")
            }
            
            self.openURL(url)
    }
}
