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
    
    public class func entityDescription(_ inContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName, in: inContext)
    }
    
    public class func insertNewObjectInContext(_ context: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: context)
    }
}

// MARK: - Sort Descriptors
extension NSManagedObject {

    public class func defaultSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor]()
    }
    
    public class func guaranteeSortDescriptors(_ potentialSortDescriptors : [NSSortDescriptor]?) -> [NSSortDescriptor] {
        
        return guarantee(potentialSortDescriptors, fallback: self.defaultSortDescriptors())
    }
    
}

// MARK: - Fetch Request
extension NSManagedObject {
    
    public class func defaultFetchRequest(_ sortDescriptors : [NSSortDescriptor]? = nil) -> NSFetchRequest<NSFetchRequestResult> {
        
        let result = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        result.sortDescriptors = guarantee(sortDescriptors, fallback: self.defaultSortDescriptors())
        return result
    }
    
    public class func guaranteeFetchRequest(_ potentialFetchRequest : NSFetchRequest<NSFetchRequestResult>?) -> NSFetchRequest<NSFetchRequestResult> {
        return guarantee(potentialFetchRequest, fallback: self.defaultFetchRequest())
    }
    
}

// MARK: - Fetched Results Controller
extension NSManagedObject {
    
    public class func defaultFetchedResultsController(_ fetchRequest : NSFetchRequest<NSFetchRequestResult>? = nil, predicate : NSPredicate? = nil, sortDescriptors : [NSSortDescriptor]? = nil, inContext context: NSManagedObjectContext) -> NSFetchedResultsController<NSFetchRequestResult> {
        
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
    
    public func saveOrLogError(_ logContext : String) -> Bool {
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
            context.delete(self)
            result = true
        } else
        {
            // TODO: throw
            result = false
        }
        
        return result
    }
    
    public func deleteAndSaveOrLogError(_ logContext : String) -> Bool {
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
