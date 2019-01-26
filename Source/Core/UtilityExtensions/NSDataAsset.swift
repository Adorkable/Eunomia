//
//  NSDataAsset.swift
//  TracksLibrary
//
//  Created by Ian Grossberg on 9/27/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif

extension NSDataAsset {
    public enum Errors: Error, CustomStringConvertible {
        case assetNotFound(name: String, bundle: Bundle)
        
        public var description: String {
            switch self {
            case .assetNotFound(let name, let bundle):
                return "Asset '\(name)' not found in bundle '\(bundle)'"
            }
        }
    }
}

extension NSDataAsset {
    public static func create(name: String, bundle: Bundle) throws -> NSDataAsset {
        guard let result = NSDataAsset(name: name, bundle: bundle) else {
            throw NSDataAsset.Errors.assetNotFound(name: name, bundle: bundle)
        }
        return result
    }
}
