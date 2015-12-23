//
//  NSCharacterSet+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

extension NSCharacterSet {
    
    // TODO: ascending and descending
    public var charactersInSetAscending : String {
        var result = String()
        
        for test in unichar.min...unichar.max - 1 {
            if self.characterIsMember(test) {
                
                var found = test
                withUnsafePointer(&found, { (testPointer) -> Void in
                    let append = NSString(characters: testPointer, length: 1)
                    result = result + (append as String)
                })
            }
        }
        
        return result
    }
}