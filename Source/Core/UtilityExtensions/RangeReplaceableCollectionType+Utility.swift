//
//  RangeReplaceableCollectionType+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

// http://stackoverflow.com/a/30724543
extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObjects(objects : [Generator.Element]) {
        for object in objects {
            if let index = self.indexOf(object) {
                self.removeAtIndex(index)
            }
        }
    }
}

