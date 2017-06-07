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
    return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
}

public func getAppDocumentPath() -> String? {
    return getAppDocumentPaths()?.first
}

public func getAppLibraryPaths() -> [String]? {
    return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
}

public func getAppLibraryPath() -> String? {
    return getAppLibraryPaths()?.first
}
