//
//  Array+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

extension Array {
    public mutating func appendIfPresent(_ newElement : Element?) {
        if let newElement = newElement {
            self.append(newElement)
        }
    }
}

extension Array {
    public var randomElement: Element? {
        guard self.count > 0 else {
            return nil
        }
        let index = random_range(0, high: UInt(self.count - 1))
        return self[index]
    }
}

extension Array {
    public subscript(index: UInt) -> Element? {
        // TODO: overflow protection
        return self[Int(index)]
    }
}

extension Array {
    open class NoMatchesFoundError: Error {
    }
    
    open class TooManyMatchesFoundError: Error {
    }
    
    public func filterOne(_ isIncluded: (Element) throws -> Bool) throws -> Element {
        let found = try self.filter(isIncluded)
        
        guard found.count < 2 else {
            throw TooManyMatchesFoundError()
        }
        
        guard let result = found.first else {
            throw NoMatchesFoundError()
        }
        
        return result
    }
}
