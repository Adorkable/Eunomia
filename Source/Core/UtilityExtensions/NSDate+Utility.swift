//
//  NSDate+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

extension NSDate
{
    public func asFileName(fileExtension : String, includeMilliseconds : Bool) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_hh-mm-ss"
        if includeMilliseconds == true
        {
            formatter.dateFormat = formatter.dateFormat + "-SSS"
        }
        return formatter.stringFromDate(self) + ".\(fileExtension)"
    }    
}