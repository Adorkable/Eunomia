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
        let index = Int.random(in: 0...(self.count - 1))
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
    public enum Errors: Error {
        case noMatchesFoundError
        case tooManyMatchesFoundError(matches: [Element])
    }
    
    public func filterOne(_ isIncluded: (Element) throws -> Bool) throws -> Element {
        let found = try self.filter(isIncluded)
        
        guard found.count < 2 else {
            throw Errors.tooManyMatchesFoundError(matches: found)
        }
        
        guard let result = found.first else {
            throw Errors.noMatchesFoundError
        }
        
        return result
    }
}
