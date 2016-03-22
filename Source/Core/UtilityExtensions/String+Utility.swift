//
//  String+Utility.swift
//  Eunomia
//
//  Created by Ian on 3/8/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public extension String
{
    public var length : Int {
        return self.characters.count
    }
    
    // TODO: deprecate in favor of joinWithSeparator
    public mutating func append(string : String, withJoin : String = "") {
        if string.length > 0
        {
            if self.length > 0
            {
                self = self + withJoin + string
            } else
            {
                self = string
            }
        }
    }
    
    subscript (index : Int) -> Character {
        return self[ self.startIndex.advancedBy(index) ]
    }
    
    subscript (index: Int) -> String {
        return String(self[index] as Character)
    }
    
    subscript (range : Range<Int>) -> String {
        let indexRange = self.startIndex.advancedBy(range.startIndex)..<startIndex.advancedBy(range.endIndex)
        return substringWithRange(indexRange)
    }
}

extension String {

    // TODO: random string without repeat
    // TODO: NSCharacterSet
    public static func randomString(length : Int, allowedCharacters : String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890") -> String {
        var result = String()
        
        for _ in 1...length
        {
            let randomCharacterIndex = Int(random_UInt32()) % allowedCharacters.length
            let randomCharacter : Character = allowedCharacters[randomCharacterIndex]
            result.append(randomCharacter)
        }
        
        return result
    }
}

extension String {
    public func data() -> NSData? {
        return self.dataUsingEncoding(NSUTF8StringEncoding)
    }
}

extension String {

    // Strict match based on http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    public func isValidEmailAddress() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return emailTest.evaluateWithObject(self)
    }
}

extension String {
    public var stringByRemovingZeroDecimalValues : String {
        var previousStep = self
        
        var cleanZero = previousStep.stringByReplacingOccurrencesOfString(".0", withString: ".")
        while cleanZero != previousStep {
            previousStep = cleanZero
            
            cleanZero = previousStep.stringByReplacingOccurrencesOfString(".0", withString: ".")
        }
        
        let decimalRange = (previousStep as NSString).rangeOfString(".")
        if decimalRange.isValid() {
            
            if decimalRange.location == previousStep.characters.count - 1 {
                
                previousStep = previousStep.stringByReplacingOccurrencesOfString(".", withString: "")
            } else {
                if previousStep.characters.count - decimalRange.location < 2 {
                    previousStep = previousStep + "0"
                }
            }
        }
        
        return previousStep
    }
}
