//
//  NSManagedObjectContext+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/24/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import CoreData

import CocoaLumberjack

extension NSManagedObjectContext
{
    public func saveOrLogError(logContext : String) -> Bool
    {
        let result : NSError?
        do {
            
            try self.save()
            result = nil
        } catch let error as NSError {
            
            DDLog.error("\(logContext): \(error)")
            result = error
        }
        
        return result == nil
    }
}