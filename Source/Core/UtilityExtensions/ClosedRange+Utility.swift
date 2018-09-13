//
//  ClosedRange+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 8/24/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

// TODO: how do I make it more generic than UnitAngle
extension ClosedRange where Bound == Measurement<UnitAngle> {
    public var value: ClosedRange<Double> {
        let uncheckedBounds = (self.lowerBound.value, self.upperBound.value)
        return ClosedRange<Double>(uncheckedBounds: uncheckedBounds)
    }
}
