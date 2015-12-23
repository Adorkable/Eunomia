//
//  NSCharacterSet+UtilityTests.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import XCTest

import Eunomia

class NSCharacterSet_UtilityTests: XCTestCase {

    // TODO: test all characters
    func testStringWithCharactersInSetAscending() {
        // "The longest words with no repeated letters are dermatoglyphics, misconjugatedly and uncopyrightables."
        
        let characters = "misconjugatedly"
        let set = NSCharacterSet(charactersInString: characters)
        
        let charactersSortedArray = characters.characters.sort()
        let charactersSorted = String(charactersSortedArray)
        
        XCTAssertEqual(set.charactersInSetAscending, charactersSorted, "Returned characters in set \"\(set.charactersInSetAscending)\" are not equal to expected characters in set \"\(charactersSorted)\"")
    }

}
