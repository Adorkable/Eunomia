//
//  UIDevice+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/24/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import UIKit

extension UIDevice
{
    public var isSimulator : Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    }
    
    public var vendorUUIDString : String? {
        return self.identifierForVendor?.uuidString
    }
}
