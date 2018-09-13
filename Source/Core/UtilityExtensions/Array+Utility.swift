//
//  Array+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

extension Array {
    public mutating func append(_ newElement : Element?) {
        if let newElement = newElement {
            self.append(newElement)
        }
    }
    
    public var randomElement: Element? {
        guard self.count > 0 else {
            return nil
        }
        let index = random_range(0, high: UInt(self.count - 1))
        return self[index]
    }
    
    public subscript(index: UInt) -> Element? {
        // TODO: overflow protection
        return self[Int(index)]
    }
}
