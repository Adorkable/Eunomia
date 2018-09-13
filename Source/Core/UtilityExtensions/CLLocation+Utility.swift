//
//  CLLocation+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 8/24/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    public convenience init(latitude: Measurement<UnitAngle>, longitude: Measurement<UnitAngle>) {
        self.init(latitude: CLLocationDegrees(from: latitude), longitude: CLLocationDegrees(from: longitude))
    }
    
    public func closest(from: [CLLocation]) -> CLLocation? {
        var result: CLLocation? = nil
        var closestDistance: CLLocationDistance = CLLocationDistance.infinity
        
        for testLocation in from {
            let testDistance = self.distance(from: testLocation)
            if result == nil || testDistance < closestDistance {
                result = testLocation
                closestDistance = testDistance
            }
        }
        
        return result
    }
}
