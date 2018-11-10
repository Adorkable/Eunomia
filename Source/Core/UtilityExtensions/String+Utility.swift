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
        return self.count
    }
    
    // TODO: deprecate in favor of joinWithSeparator
    public mutating func append(_ string : String, withJoin : String = "") {
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
        return self[ self.index(self.startIndex, offsetBy: index) ]
    }
    
    subscript (index: Int) -> String {
        return String(self[index] as Character)
    }
    
    subscript (range : Range<Int>) -> String {
        let indexRange = self.index(self.startIndex, offsetBy: range.lowerBound)..<self.index(startIndex, offsetBy: range.upperBound)
        return String(self[indexRange.lowerBound...indexRange.upperBound])
    }

    // From https://stackoverflow.com/a/39612638
    subscript (range: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: range.upperBound - range.lowerBound)
        return String(self[startIndex...endIndex])
    }
}

extension String {

    // TODO: random string without repeat
    // TODO: NSCharacterSet
    public static func randomString(_ length : Int, allowedCharacters : String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890") -> String {
        var result = String()
        
        for _ in 1...length
        {
            guard let randomCharacter : Character = allowedCharacters.randomElement() else {
                break
            }
            result.append(randomCharacter)
        }
        
        return result
    }
}

extension String {
    public func data() -> Data? {
        return self.data(using: String.Encoding.utf8)
    }
}

extension String {

    // Strict match based on http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    public func isValidEmailAddress() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return emailTest.evaluate(with: self)
    }
}

extension String {
    public var stringByRemovingZeroDecimalValues : String {
        var previousStep = self
        
        var cleanZero = previousStep.replacingOccurrences(of: ".0", with: ".")
        while cleanZero != previousStep {
            previousStep = cleanZero
            
            cleanZero = previousStep.replacingOccurrences(of: ".0", with: ".")
        }
        
        let decimalRange = (previousStep as NSString).range(of: ".")
        if decimalRange.isValid() {
            
            if decimalRange.location == previousStep.count - 1 {
                
                previousStep = previousStep.replacingOccurrences(of: ".", with: "")
            } else {
                if previousStep.count - decimalRange.location < 2 {
                    previousStep = previousStep + "0"
                }
            }
        }
        
        return previousStep
    }
}

// Based on: https://useyourloaf.com/blog/swift-hashable/
extension String {
    public var djb2hash: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
    
    public var sdbmhash: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(0) {
            Int($1) &+ ($0 << 6) &+ ($0 << 16) - $0
        }
    }
}

