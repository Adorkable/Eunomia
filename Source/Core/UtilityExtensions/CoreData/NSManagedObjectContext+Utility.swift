//
//  NSManagedObjectContext+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/24/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import CoreData

extension NSManagedObjectContext
{
    public func saveOrLogError(_ logContext : String) -> Bool
    {
        let result : NSError?
        do {
            
            try self.save()
            result = nil
        } catch let error as NSError {
            
            Log.error(message: "\(logContext): \(error)")
            result = error
        }
        
        return result == nil
    }
}
