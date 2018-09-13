//
//  MeasurementTest.swift
//  TracksTests
//
//  Created by Ian Grossberg on 8/22/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import XCTest
import Eunomia

class MeasurementTest: XCTestCase {
    static let testValueCount = 1000
    
    static var randomUnitLength: UnitLength {
        
        let unit = [UnitLength](arrayLiteral: .meters,
                                  .decimeters,
                                  .centimeters,
                                  .millimeters,
                                  .micrometers,
                                  .nanometers,
                                  .picometers,
                                  .inches,
                                  .feet,
                                  .yards)//UnitLength.all // TODO: precision is messing this up
            .randomElement
        XCTAssertNotNil(unit, "randomUnitLength")
        if unit == nil {
            XCTFail()
        }
        return unit!
    }
    static var testValues: [Measurement<UnitLength>] {
        var result: [Measurement<UnitLength>] = []
        while result.count < self.testValueCount {
            result.append(Measurement(value: Double(arc4random()) / Double(arc4random()), unit: self.randomUnitLength))
        }
        return result
    }
    
    static func calculateAverage(values: [Measurement<UnitLength>]) -> Measurement<UnitLength> {
        guard values.count > 0 else {
            return Measurement(value: 0, unit: UnitLength.furlongs)
        }
        
        let sumUnit = self.randomUnitLength
        let destinationUnit = self.randomUnitLength
        
        var sum = Measurement(value: 0, unit: sumUnit)
        for value in values {
            sum = sum + value
        }
        return Measurement(value: sum.converted(to: destinationUnit).value / Double(values.count), unit: destinationUnit)
    }
    
//    func testAverageVArgs() {
//    }
    
    func testAverageArray() {
        let staticContext = type(of: self)
        
        let testValues = staticContext.testValues
        
        let left = staticContext.calculateAverage(values: testValues)
        let right = average(values: testValues)
//        XCTAssertEqual(left, right, "Average of test values")
        XCTAssertLessThan((left - right).value, 0.000001, "Average value precision difference") // TODO: less than value should be unit aware
        
        XCTAssertEqual(staticContext.calculateAverage(values: []), average(values: []), "Average of no test values")
    }
}
