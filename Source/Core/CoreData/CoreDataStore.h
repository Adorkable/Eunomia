//
//  CoreDataStore.h
//  Eunomia
//
//  Created by Ian Grossberg on 5/23/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol CoreDataStoreObject;

@interface CoreDataStore : NSObject

- (id)initWithBaseURL:(NSURL *)baseURL shouldInitPersistentStore:(BOOL)initPersistentStore nameOfDataModel:(NSString *)nameOfDataModel;

@property (readonly) NSManagedObjectContext *mainQueueManagedObjectContext;

- (NSEntityDescription *)entityDescriptionForEntityName:(NSString *)name;

- (NSFetchedResultsController *)fetchedResultsController:(NSFetchRequest *)fetchResults;
- (NSFetchedResultsController *)fetchedResultsControllerWithEntityName:(NSString *)entityName
                                                          andPredicate:(NSPredicate *)predicate;
- (NSFetchedResultsController *)fetchedResultsControllerWithEntityName:(NSString *)entityName
                                                          andPredicate:(NSPredicate *)predicate
                                                    andSortDescriptors:(NSArray *)sortDescriptors;

- (id)insertNewInstance:(Class)ofClass withEntityName:(NSString *)entityName;
- (id)insertNewInstance:(Class<CoreDataStoreObject>)coreDataStoreObject;

@end

@protocol CoreDataStoreObject <NSObject>

@required
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;

@end
