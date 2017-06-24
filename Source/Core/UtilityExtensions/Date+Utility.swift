//
//  Date+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 6/23/17.
//  Copyright © 2017 Adorkable. All rights reserved.
//

import Foundation

extension Date
{
    public func asFileName(_ fileExtension : String, includeMilliseconds : Bool) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_hh-mm-ss"
        if includeMilliseconds == true
        {
            formatter.dateFormat = formatter.dateFormat + "-SSS"
        }
        return formatter.string(from: self) + ".\(fileExtension)"
    }
}

func - (left: Date, right: Date) -> TimeInterval {
    return left.timeIntervalSince1970 - right.timeIntervalSince1970
}
