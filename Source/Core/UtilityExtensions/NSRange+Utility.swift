//
//  NSRange+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/25/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

extension NSRange {
    
    func isValid() -> Bool {
        return self.location != NSNotFound && self.length > 0
    }
}