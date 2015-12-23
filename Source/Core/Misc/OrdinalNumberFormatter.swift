//
//  OrdinalNumberFormatter.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

import CocoaLumberjack

// translated from http://stackoverflow.com/a/3316016
public class OrdinalNumberFormatter: NSNumberFormatter {

    override public func getObjectValue(obj: AutoreleasingUnsafeMutablePointer<AnyObject?>, forString string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>) -> Bool {
        var integerNumber : Int = 0
        var isSuccessful = false
        
        let scanner = NSScanner(string: string)
        scanner.caseSensitive = false
        scanner.charactersToBeSkipped = NSCharacterSet.letterCharacterSet()
        
        if scanner.scanInteger(&integerNumber) == true
        {
            isSuccessful = true
            obj.memory = NSNumber(integer: integerNumber)
        } else
        {
            if let error = error.memory
            {
                DDLog.error("Unable to create number from \(string): \(error)")
            }
        }
        
        return isSuccessful
    }
    
    override public func stringForObjectValue(obj: AnyObject) -> String? {
        if !obj.isKindOfClass(NSNumber.self)
        {
            return nil
        }
        var result : String?

        if let stringRepresentation = obj.stringValue
        {
            if stringRepresentation.characters.count > 0
            {
                var ordinal : String?
                
                if stringRepresentation == "11" || stringRepresentation == "12" || stringRepresentation == "13"
                {
                    ordinal = "th"
                } else if let lastDigit = stringRepresentation.characters.last
                {
                    ordinal = OrdinalNumberFormatter.ordinalSuffixForLastDigit(lastDigit)
                }
                
                if let ordinal = ordinal
                {
                    result = "\(stringRepresentation)\(ordinal)"
                }
            }
        }
        
        return result
    }
    
    public class func ordinalSuffixForLastDigit(digit : Character) -> String? {
        var result : String?
        
        if digit == "1"
        {
            result = "st"
        } else if digit == "2"
        {
            result = "nd"
        } else if digit == "3"
        {
            result = "rd"
        } else
        {
            result = "th"
        }

        return result
    }
}
