//
//  Random.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/**
  Generates random value between 0.0 inclusive and 1.0 inclusive

:returns: a random value between 0.0 inclusive and 1.0 inclusive
*/
public func randomf() -> Double
{
    return Double(random_UInt32()) / Double(UInt32.max)
}

public func random_UInt32() -> UInt32
{
    return arc4random()
}

public func random_range_UInt32(low : UInt32, high : UInt32) -> UInt32 {
    return UInt32( arc4random_uniform(UInt32(high - low + 1) ) ) + low
}

public func random_range(low : UInt, high : UInt) -> UInt {
    return UInt(arc4random_uniform(UInt32(high - low + 1) ) ) + low
}