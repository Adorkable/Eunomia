//
//  String+UtilityTests.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import XCTest

import Eunomia

class String_UtilityTests: XCTestCase {
    
    func testLength() {
        let test = "ASLKDFJLAKSJDFasdlfkjals;dkfjoaije"
        
        XCTAssertEqual(test.length, test.characters.count)
    }
    
    func testAppend() {
        let zero = ""
        let notZero = "1234"
        let notZeroAppend = "ASDF"
        let join = "::"
        
        var selfZero = zero
        selfZero.append(notZeroAppend, withJoin: join)
        XCTAssertEqual(selfZero, notZeroAppend)
        
        var selfNotZero = notZero
        selfNotZero.append(notZeroAppend, withJoin: join)
        XCTAssertEqual(selfNotZero, notZero + join + notZeroAppend)
        
        selfNotZero = notZero
        selfNotZero.append(zero, withJoin: join)
        XCTAssertEqual(selfNotZero, notZero)
    }
    
    // TODO: subscript -> Character
    // TODO: subscript -> String

    // TODO: randomString()
    
    func testData() {
        let test = "ASDF@#$54235hsdfsgd;]345"
        
        XCTAssertEqual(test.data(), test.dataUsingEncoding(NSUTF8StringEncoding))
    }
    
    // TODO: thorough valid characters and format testing
    func testIsValidEmailAddress() {
        
        var valid = "yo.ian.g@gmail.com"
        XCTAssertTrue(valid.isValidEmailAddress(), "\(valid) is a valid email address")
        
        valid = "asdf@asdf.io"
        XCTAssertTrue(valid.isValidEmailAddress(), "\(valid) is a valid email address")
        
        valid = "asdf@asdf.museum"
        XCTAssertTrue(valid.isValidEmailAddress(), "\(valid) is a valid email address")
        
        var invalid = "asdf@asdf"
        XCTAssertFalse(invalid.isValidEmailAddress(), "\(invalid) is an invalid email address")

        invalid = "asdf@asdf.i"
        XCTAssertFalse(invalid.isValidEmailAddress(), "\(invalid) is an invalid email address")
        
        invalid = "2345"
        XCTAssertFalse(invalid.isValidEmailAddress(), "\(invalid) is an invalid email address")
    }
}
