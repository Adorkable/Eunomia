//
//  NSFetchedResultsController+Utility.m
//  Eunomia
//
//  Created by Ian on 5/24/14.
//

#import "NSFetchedResultsController+Utility.h"

@implementation NSFetchedResultsController (Eunomia_Utility)

+ (id)firstResultWithFetchRequest:(NSFetchRequest *)fetchRequest
             managedObjectContext:(NSManagedObjectContext *)context
               sectionNameKeyPath:(NSString *)sectionNameKeyPath
                        cacheName:(NSString *)name
                            error:(NSError **)error
{
    NSFetchedResultsController *fetchResultsController = [ [NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                              managedObjectContext:context
                                                                                                sectionNameKeyPath:sectionNameKeyPath
                                                                                                         cacheName:name];
    
    return [fetchResultsController firstResultOfPerformFetch:error];
}

- (id)firstResultOfPerformFetch:(NSError **)error
{
    id result;
    [self performFetch:error];
    
    if (self.fetchedObjects.count > 0)
    {
        result = [self.fetchedObjects firstObject];
    }
    
    return result;
}

@end
