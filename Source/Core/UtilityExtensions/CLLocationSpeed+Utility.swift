//
//  CLLocationSpeed+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 9/22/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import CoreLocation

extension CLLocationSpeed {
    public var unitSpeed: Measurement<UnitSpeed> {
        return Measurement(value: self, unit: UnitSpeed.metersPerSecond)
    }
}
