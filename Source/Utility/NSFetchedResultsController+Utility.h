//
//  NSFetchedResultsController+Utility.h
//  Eunomia
//
//  Created by Ian on 5/24/14.
//

#import <CoreData/CoreData.h>

@interface NSFetchedResultsController (Eunomia_Utility)

+ (id)firstResultWithFetchRequest:(NSFetchRequest *)fetchRequest
             managedObjectContext:(NSManagedObjectContext *)context
               sectionNameKeyPath:(NSString *)sectionNameKeyPath
                        cacheName:(NSString *)name
                            error:(NSError **)error;

- (id)firstResultOfPerformFetch:(NSError **)error;

@end
