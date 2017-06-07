//
//  NSNotification+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

extension Notification {
    
    public func objectFromInfo(_ key : String) -> AnyObject? {
        return self.userInfo?[key] as AnyObject
    }
}
