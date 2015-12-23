//
//  Dictionary+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

extension Dictionary {
    
    public mutating func updateValue(value: Value?, forKey key: Key) -> Value? {

        if let value = value {
            
            self[key] = value
        } else {
            
            self.removeValueForKey(key)
        }
        
        return value
    }
}