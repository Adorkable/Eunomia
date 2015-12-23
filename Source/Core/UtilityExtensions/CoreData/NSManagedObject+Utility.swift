//
//  NSManagedObject+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

import CoreData

// MARK: - Creation
extension NSManagedObject {
    
    public class var entityName : String { // Assumes we've named our CoreData object the same as the Class object
        
        let fullClassName: String = NSStringFromClass(object_getClass(self))
        let classNameComponents: [String] = fullClassName.characters.split { $0 == "." }.map { String($0) }
        return classNameComponents.last!
    }
    
    public class func entityDescription(inContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entityForName(self.entityName, inManagedObjectContext: inContext)
    }
    
    public class func insertNewObjectInContext(context: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext: context)
    }
}

// MARK: - Sort Descriptors
extension NSManagedObject {

    public class func defaultSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor]()
    }
    
    public class func guaranteeSortDescriptors(potentialSortDescriptors : [NSSortDescriptor]?) -> [NSSortDescriptor] {
        
        return guarantee(potentialSortDescriptors, fallback: self.defaultSortDescriptors())
    }
    
}

// MARK: - Fetch Request
extension NSManagedObject {
    
    public class func defaultFetchRequest(sortDescriptors : [NSSortDescriptor]? = nil) -> NSFetchRequest {
        
        let result = NSFetchRequest(entityName: self.entityName)
        result.sortDescriptors = guarantee(sortDescriptors, fallback: self.defaultSortDescriptors())
        return result
    }
    
    public class func guaranteeFetchRequest(potentialFetchRequest : NSFetchRequest?) -> NSFetchRequest {
        return guarantee(potentialFetchRequest, fallback: self.defaultFetchRequest())
    }
    
}

// MARK: - Fetched Results Controller
extension NSManagedObject {
    
    public class func defaultFetchedResultsController(fetchRequest : NSFetchRequest? = nil, predicate : NSPredicate? = nil, sortDescriptors : [NSSortDescriptor]? = nil, inContext context: NSManagedObjectContext) -> NSFetchedResultsController {
        
        let useFetchRequest = guarantee(fetchRequest, fallback: self.defaultFetchRequest())
        
        if let predicate = predicate {
            useFetchRequest.predicate = predicate
        }
        
        if let sortDescriptors = sortDescriptors {
            useFetchRequest.sortDescriptors = sortDescriptors
        }
        
        return NSFetchedResultsController(fetchRequest: useFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
}

// MARK: - Save
extension NSManagedObject {
    
    public func saveOrLogError(logContext : String) -> Bool {
        var result : Bool
        
        if let context = self.managedObjectContext
        {
            result = context.saveOrLogError(logContext)
        } else
        {
            // TODO: throw
            result = false
        }
        
        return result
    }
}

// MARK: - Delete
extension NSManagedObject {
    
    public func deleteObject() -> Bool {
        var result : Bool
        
        if let context = self.managedObjectContext
        {
            context.deleteObject(self)
            result = true
        } else
        {
            // TODO: throw
            result = false
        }
        
        return result
    }
    
    public func deleteAndSaveOrLogError(logContext : String) -> Bool {
        var result : Bool
        
        if let context = self.managedObjectContext
        {
            // TODO: let user know if delete or save failed
            result = self.deleteObject()
            if result == true
            {
                result = context.saveOrLogError(logContext)
            }
        } else
        {
            // TODO: throw
            result = false
        }
        
        return result
    }
}