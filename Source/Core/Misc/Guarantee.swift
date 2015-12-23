//
//  Guarantee.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/12/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

public func guarantee<T>(potential : T?, @autoclosure fallback : (() -> T) ) -> T {
    
    let result : T
    if let actual = potential {
        result = actual
    } else {
        result = fallback()
    }
    return result
}
