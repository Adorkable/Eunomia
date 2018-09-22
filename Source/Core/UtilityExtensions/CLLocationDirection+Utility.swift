//
//  CLLocationDirection+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 9/22/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationDirection {
    public init(from: Measurement<UnitAngle>) {
        self = from.converted(to: .degrees).value
    }
    
    public init(fromRadians from: Double) {
        self = Measurement(value: from, unit: UnitAngle.radians).converted(to: .degrees).value
    }
    
    public var inDegrees: Measurement<UnitAngle> {
        return Measurement(value: self, unit: UnitAngle.degrees)
    }
    
    public var inRadians: Measurement<UnitAngle> {
        return self.inDegrees.converted(to: .radians)
    }
}
