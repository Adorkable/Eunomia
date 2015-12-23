//
//  Array+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

extension Array {
    
    public mutating func append(newElement : Element?) {
        
        if let newElement = newElement {
            self.append(newElement)
        }
    }
}