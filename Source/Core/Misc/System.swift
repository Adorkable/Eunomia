//
//  System.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

// TODO: vs NSFileManager.defaultManager().URLsForDirectory?
// TODO: UIApplicationExtension?
public func getAppDocumentPaths() -> [String]? {
    return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
}

public func getAppDocumentPath() -> String? {
    return getAppDocumentPaths()?.first
}

public func getAppLibraryPaths() -> [String]? {
    return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true)
}

public func getAppLibraryPath() -> String? {
    return getAppLibraryPaths()?.first
}