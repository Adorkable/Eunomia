//
//  CLLocationDegrees+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 8/24/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationDegrees {
    public init(from: Measurement<UnitAngle>) {
        self = from.converted(to: .degrees).value
    }
    
    public init(fromRadians from: Double) {
        self = Measurement(value: from, unit: UnitAngle.radians).converted(to: .degrees).value
    }
    
    public var asMeasurement: Measurement<UnitAngle> {
        return Measurement(value: self, unit: UnitAngle.degrees)
    }
    
    public var inRadians: Measurement<UnitAngle> {
        return self.asMeasurement.converted(to: .radians)
    }
}

extension CLLocationDegrees {
    public static let latitudeMinimum: CLLocationDegrees = -90
    public static let latitudeMaximum: CLLocationDegrees = 90
    public static let longitudeMinimum: CLLocationDegrees = -180
    public static let longitudeMaximum: CLLocationDegrees = 180
}
