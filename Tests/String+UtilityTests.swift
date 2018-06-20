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
        
        XCTAssertEqual(test.length, test.count)
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
    
    func testSubscriptCharacterResult() {
        let test = [Character("A"),Character("S"),Character("L"),Character("K"),Character("D"),Character("F"),Character("J"),Character("L"),Character("A"),Character("K"),Character("S"),Character("J"),Character("D"),Character("F"),Character("a"),Character("s"),Character("d"),Character("l"),Character("f"),Character("k"),Character("j"),Character("a"),Character("l"),Character("s"),Character(";"),Character("d"),Character("k"),Character("f"),Character("j"),Character("o"),Character("a"),Character("i"),Character("j"),Character("e")]
        
        
        let index = arc4random() % UInt32(test.count)
        let string = test.map({String($0)}).joined(separator: "")

        XCTAssertEqual(test[Int(index)], string[Int(index)])
    }
    
    func testSubscriptStringResult() {
        let test = ["A", "S", "L", "K", "D", "F", "J", "L","A","K","S","J","D","F","a","s","d","l","f","k","j","a","l","s",";","d","k","f","j","o","a","i","j","e"]

        
        let index = arc4random() % UInt32(test.count)
        let string = test.joined(separator: "")

        XCTAssertEqual(test[Int(index)], string[Int(index)])
    }
    
    func testSubstringIntRangeIndex() {
        let test = ["A", "S", "L", "K", "D", "F", "J", "L","A","K","S","J","D","F","a","s","d","l","f","k","j","a","l","s",";","d","k","f","j","o","a","i","j","e"]
        
        
        let index = 3..<10
        let testString = test[index].joined(separator: "")
        let string = test.joined(separator: "")

        XCTAssertEqual(testString, string[index])
    }

    // TODO: randomString()
    
//    func testData() {
//        let test = "ASDF@#$54235hsdfsgd;]345"
//        
//        XCTAssertEqual(test.data(using: <#String.Encoding#>), test.data(using: String.Encoding.utf8))
//    }

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
