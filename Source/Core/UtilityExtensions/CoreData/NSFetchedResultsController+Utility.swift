//
//  NSFetchedResultsController+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import CoreData

extension NSFetchedResultsController {
    
    convenience init(fetchObjectType : NSManagedObject.Type, managedObjectContext context : NSManagedObjectContext, sectionNameKeyPath : String? = nil, cacheName : String? = nil) {
        
        let useFetchRequest = fetchObjectType.guaranteeFetchRequest(nil)
        self.init(fetchRequest: useFetchRequest, managedObjectContext: context, sectionNameKeyPath: sectionNameKeyPath, cacheName: cacheName)
    }
    
    public func firstResultOfPerformFetch() throws -> AnyObject? {
        var result : AnyObject?
        
        try self.performFetch()
        
        if let fetchedObjects = self.fetchedObjects
        {
            result = fetchedObjects.first
        }
        
        return result
    }
    
    public class func firstResult(fetchRequest : NSFetchRequest, context : NSManagedObjectContext, sectionNameKeyPath : String? = nil, cacheName : String? = nil) throws -> AnyObject? {
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: sectionNameKeyPath, cacheName: cacheName)
        return try fetchedResultsController.firstResultOfPerformFetch()
    }
    
    public var fetchedObjectsCount : Int {
        return guarantee(self.fetchedObjects?.count, fallback: 0)
    }
    
    public class func fetchedObjectsCount(fetchObjectType : NSManagedObject.Type, context : NSManagedObjectContext, sectionNameKeyPath : String? = nil, cacheName : String? = nil) throws -> Int {
        
        let fetchedResultsController = NSFetchedResultsController(fetchObjectType: fetchObjectType, managedObjectContext: context, sectionNameKeyPath: sectionNameKeyPath, cacheName: cacheName)
        try fetchedResultsController.performFetch()
        
        return fetchedResultsController.fetchedObjectsCount
    }
}