//
//  CLLocationCoordinate2D.swift
//  Tracks
//
//  Created by Ian Grossberg on 8/22/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    public init(from: (Measurement<UnitAngle>, Measurement<UnitAngle>)) {
        self.init(latitude: CLLocationDegrees(from: from.0), longitude: CLLocationDegrees(from: from.1))
    }
    
    public init(fromRadians from: (Double, Double)) {
        self.init(latitude: CLLocationDegrees(fromRadians: from.0), longitude: CLLocationDegrees(fromRadians: from.1))
    }
    
    public var asMeasurement: (Measurement<UnitAngle>, Measurement<UnitAngle>) {
        return (
            self.latitude.inRadians,
            self.longitude.inRadians
        )
    }
    
    public var inRadians: (Double, Double) {
        let asMeasurement = self.asMeasurement
        return (
             asMeasurement.0.value,
             asMeasurement.1.value
        )
    }
}
