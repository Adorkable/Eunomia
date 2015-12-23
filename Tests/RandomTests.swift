//
//  RandomTests.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation
import XCTest

import Eunomia

class RandomTests: XCTestCase {
    
    func testRandomf() {
        for _ in 1...100
        {
            let value = randomf()
            XCTAssertGreaterThanOrEqual(value, 0.0, "Result should be greater than or equal to 0")
            XCTAssertLessThanOrEqual(value, 1.0, "Result should be less than or equal to 1.0")
        }
    }
}
