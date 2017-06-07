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
        return self.model == "iPhone Simulator" || self.name == "iPhone Simulator"
    }
    
    public var vendorUUIDString : String? {
        return self.identifierForVendor?.uuidString
    }
}
