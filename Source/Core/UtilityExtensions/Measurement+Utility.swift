//
//  Measurement+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 8/22/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

public extension UnitLength {
    public static var all: [UnitLength] {
        return [
            .megameters,
            .kilometers,
            .hectometers,
            .decameters,
            .meters,
            .decimeters,
            .centimeters,
            .millimeters,
            .micrometers,
            .nanometers,
            .picometers,
            .inches,
            .feet,
            .yards,
            .miles,
            .scandinavianMiles,
            .lightyears,
            .nauticalMiles,
            .fathoms,
            .furlongs,
            .astronomicalUnits,
            .parsecs
        ]
    }
}

public func average(values: Measurement<UnitLength>...) -> Measurement<UnitLength> {
    return average(values: values)
}

public func average(values: [Measurement<UnitLength>]) -> Measurement<UnitLength> {
    guard values.count > 0 else {
        return Measurement(value: 0, unit: UnitLength.furlongs)
    }
    
    let resultUnitType = values[0].unit
    let sum = values.reduce(Measurement(value: 0, unit: resultUnitType)) { (accumulated, next) -> Measurement<UnitLength> in
        return accumulated + next
    }
    
    return Measurement(value: sum.converted(to: resultUnitType).value / Double(values.count), unit: resultUnitType)
}

public func average(values: Measurement<UnitSpeed>...) -> Measurement<UnitSpeed> {
    return average(values: values)
}

public func average(values: [Measurement<UnitSpeed>]) -> Measurement<UnitSpeed> {
    guard values.count > 0 else {
        return Measurement(value: 0, unit: UnitSpeed.knots)
    }
    
    let resultUnitType = values[0].unit
    let sum = values.reduce(Measurement(value: 0, unit: resultUnitType)) { (accumulated, next) -> Measurement<UnitSpeed> in
        return accumulated + next
    }
    
    return Measurement(value: sum.converted(to: resultUnitType).value / Double(values.count), unit: resultUnitType)
}

public func *(left: Measurement<UnitSpeed>, right: Measurement<UnitDuration>) -> Measurement<UnitLength> {
    let valueInMeters = left.converted(to: UnitSpeed.metersPerSecond).value * right.converted(to: UnitDuration.seconds).value
    return Measurement(value: valueInMeters, unit: UnitLength.meters)
}

public func *(left: Measurement<UnitLength>, right: Measurement<UnitLength>) -> Measurement<UnitLength> {
    let valueInMeters = left.converted(to: UnitLength.meters).value * right.converted(to: UnitLength.meters).value
    return Measurement(value: valueInMeters, unit: UnitLength.meters)
}
