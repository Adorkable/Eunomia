//
//  RangeReplaceableCollectionType+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

// http://stackoverflow.com/a/30724543
extension RangeReplaceableCollection where Iterator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(_ object : Iterator.Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObjects(_ objects : [Iterator.Element]) {
        for object in objects {
            if let index = self.index(of: object) {
                self.remove(at: index)
            }
        }
    }
}

