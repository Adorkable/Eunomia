//
//  ManagedObjectsObserver.swift
//  Eunomia
//
//  Created by Ian Grossberg on 9/9/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

/*
import Foundation

import CoreData

public class ManagedObjectsObserver : NSObject {
    private let observer : NSFetchedResultsController
    public var fetchedObjects : [NSManagedObject]? {
        return self.observer.fetchedObjects as? [NSManagedObject]
    }
    
    private var insertChanges = [NSIndexPath]()
    private var deleteChanges = [NSIndexPath]()
    // TODO: Moves and Updates
    
    public typealias OnObjectsDidChange = ( (controller: NSFetchedResultsController, insertChanges : [NSIndexPath], deleteChanges : [NSIndexPath]) -> Void)
    public var onObjectsDidChange : OnObjectsDidChange?
    
    public init(observer : NSFetchedResultsController, onObjectsDidChange : OnObjectsDidChange? = nil) {
        self.observer = observer
        self.onObjectsDidChange = onObjectsDidChange
        
        super.init()
        
        self.observer.delegate = self
    }
    
    deinit {
        self.observer.delegate = nil
    }
    
    public func refresh() throws {
        try self.observer.performFetch()
    }
    
    public var count : Int {
        return guarantee(self.fetchedObjects?.count, fallback: 0)
    }
    
    public func objectAtIndex(index : Int) -> NSManagedObject? {
        guard let fetchedObjects = fetchedObjects else {
            return nil
        }
        
        guard index < fetchedObjects.count else {
            return nil
        }
        
        return fetchedObjects[index]
    }
    
    public func objectAtIndex<T : NSManagedObject>(index : Int) -> T? {
        guard let fetchedObjects = fetchedObjects else {
            return nil
        }
        
        guard index < fetchedObjects.count else {
            return nil
        }
        
        return fetchedObjects[index] as? T
    }
    
    // TODO: subscript
}

extension ManagedObjectsObserver : NSFetchedResultsControllerDelegate {
    
    public func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.insertChanges.removeAll()
        self.deleteChanges.removeAll()
    }
    
    public func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            if let newIndexPath = newIndexPath {
                // TODO: should include object
                self.insertChanges.append(newIndexPath)
            } else {
                DDLog.error("Expected new index path with Insert")
            }
            break
            
        case .Delete:
            if let indexPath = indexPath {
                // TODO: should include object
                self.deleteChanges.append(indexPath)
            } else {
                DDLog.error("Expected index path with Delete")
            }
            
        default:
            break
        }
    }
    
    public func controllerDidChangeContent(controller: NSFetchedResultsController) {

//        guard self.insertChanges.count > 0 || self.deleteChanges.count > 0 else {
//            
//            DDLog.verbose("No values inserted or deleted, not notifying of changes")
//            return
//        }
        
        guard let onObjectsDidChange = self.onObjectsDidChange else {
            return
        }
        
        onObjectsDidChange(controller: controller, insertChanges: self.insertChanges, deleteChanges: self.deleteChanges)
    }
}
*/
