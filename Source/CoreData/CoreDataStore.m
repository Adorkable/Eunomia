//
//  CoreDataStore.m
//  Eunomia
//
//  Created by Ian Grossberg on 5/23/14.
//
//

#import "CoreDataStore.h"

#import "Eunomia.h"

// TODO: CoreDataStoreManager/RestKitCoreDataStoreManager components

@interface CoreDataStore ()

@property (strong, readwrite) NSManagedObjectModel *managedObjectModel;
#if USE_RESTKIT
@property (strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
#else
@property (strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, readwrite) NSPersistentStore *persistentStore;
#endif

@end

@implementation CoreDataStore

- (id)initWithBaseURL:(NSURL *)baseURL shouldInitPersistentStore:(BOOL)initPersistentStore nameOfDataModel:(NSString *)nameOfDataModel
{
    self = [super init];
    if (self)
    {
        [self initDatabaseWithBaseURL:baseURL shouldInitPersistentStore:initPersistentStore nameOfDataModel:nameOfDataModel];
    }
    return self;
}

- (void)initDatabaseWithBaseURL:(NSURL *)baseURL shouldInitPersistentStore:(BOOL)initPersistentStore nameOfDataModel:(NSString *)nameOfDataModel
{
    NSURL *urlOfDataModel = [CoreDataStore urlOfDataModel:nameOfDataModel];
    
    self.managedObjectModel = [self getManagedObjectModelAtURL:urlOfDataModel];
    
    [self createPersistentStoreCoordinator:baseURL withManagedObjectModel:self.managedObjectModel];
    
    BOOL result = NO;
    if (initPersistentStore)
    {
        NSURL *urlOfPersistentStore = [CoreDataStore urlOfPersistentStore:nameOfDataModel]; //inUserDirectory:NSCachesDirectory];
        
        NSDictionary *currentPersistentStoreMetadata = [CoreDataStore persistentStoreMetadata:NSSQLiteStoreType atURL:urlOfPersistentStore];
        if ( [CoreDataStore isMigrationNeeded:currentPersistentStoreMetadata forCurrentModel:self.managedObjectModel] )
        {
            NSLogError(@"Implement migration");
        }
        
        result = [self initPersistentStoreAtURL:urlOfPersistentStore];
    } else
    {
        // TODO: organize better, doesn't make sense with "initPersistentStore" flag
        result = [self initInMemoryStore];
    }
    
    if (result)
    {
        result = [self optionallyCreateManagedObjectContexts:self.persistentStoreCoordinator];
    } else
    {
        NSLogWarn(@"Skipping creating managed object contexts due to previous failure");
    }
    
    if (result)
    {
#if USE_AFNETWORKING
        [ [AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
#endif
        
        NSLogInfo(@"%@ Rest Kit + Core Data initialized", nameOfDataModel);

#if USE_PONYDEBUG
        id<UIApplicationDelegate> applicationDelegate = [UIApplication sharedApplication].delegate;
        if( [applicationDelegate isKindOfClass:[AppDelegate class] ] )
        {
            AppDelegate *appDelegate = applicationDelegate;
            [appDelegate initPonyDebuggerCodeDataDebugging:self.rkObjectManager.managedObjectStore.mainQueueManagedObjectContext withName:urlForContentDataStore];
        }
#endif

#if USE_RESTKIT
        // Trouble using NSJSONSerialization, not proper results!
        NSString *JSONMIMEType = @"application/json";
        [RKMIMETypeSerialization registerClass:[CCJSONSerializer class] forMIMEType:JSONMIMEType];
        self.rkObjectManager.requestSerializationMIMEType = JSONMIMEType;
        /*        RKLogConfigureByName("App", RKLogLevelInfo);
         RKLogConfigureByName("RestKit", RKLogLevelWarning);
         RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
         RKLogConfigureByName("RestKit/CoreData/Cache", RKLogLevelTrace);
         RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
         RKLogConfigureByName("RestKit/Network/CoreData", RKLogLevelTrace);
         RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
         RKLogConfigureByName("RestKit/Search", RKLogLevelTrace);
         RKLogConfigureByName("RestKit/Support", RKLogLevelTrace);
         RKLogConfigureByName("RestKit/Testing", RKLogLevelTrace);
         RKLogConfigureByName("RestKit/UI", RKLogLevelTrace);
         */
#endif
    } else
    {
        NSLogError(@"%@ Rest Kit + Core Data initialization failed", nameOfDataModel);
    }
}

#pragma mark Component Initialization

+ (NSURL *)urlOfDataModel:(NSString *)nameOfDataModel
{
    NSURL *result = [ [NSBundle mainBundle] URLForResource:nameOfDataModel withExtension:@"momd"];
    
    if (!result)
    {
        result = [ [NSBundle mainBundle] URLForResource:nameOfDataModel withExtension:@"mom"];
    }
    
    return result;
}

- (NSManagedObjectModel *)getManagedObjectModelAtURL:(NSURL *)url
{
    return [ [NSManagedObjectModel alloc] initWithContentsOfURL:url];
}

+ (BOOL)isMigrationNeeded:(NSDictionary *)currentPersistentStoreMetadata
          forCurrentModel:(NSManagedObjectModel *)currentModel
{
    // based on https://github.com/objcio/issue-4-core-data-migration
    BOOL result = NO;
    
    if (currentPersistentStoreMetadata != nil)
    {
        result = ![currentModel isConfiguration:nil compatibleWithStoreMetadata:currentPersistentStoreMetadata];
    }
    
    return result;
}

- (void)createPersistentStoreCoordinator:(NSURL *)baseURL withManagedObjectModel:(NSManagedObjectModel *)model
{
#if USE_RESTKIT
    self.rkObjectManager = [RKObjectManager managerWithBaseURL:baseURL];
    self.rkObjectManager.managedObjectStore = [ [RKManagedObjectStore alloc] initWithManagedObjectModel:model];
#else
    self.persistentStoreCoordinator = [ [NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
#endif
}

#if !(USE_RESTKIT==1)
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)setPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    _persistentStoreCoordinator = persistentStoreCoordinator;
}
#endif

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    NSPersistentStoreCoordinator *result;
#if USE_RESTKIT
    result = self.rkObjectManager.managedObjectStore.persistentStoreCoordinator;
#else
    result = _persistentStoreCoordinator;
#endif
    
    return result;
}

- (BOOL)initPersistentStoreAtURL:(NSURL *)url
{
    BOOL result = [self addSQLitePersistentStoreAtPath:url];
    if (!result)
    {
        // TODO: test path
        NSError *error;
        [ [NSFileManager defaultManager] removeItemAtURL:url error:&error];
        if (error)
        {
            NSLogError(@"When attempting to reset the persistent store at path %@: %@", url, error);
            // TODO: fatal?
        } else
        {
            result = [self addSQLitePersistentStoreAtPath:url];
            if (!result)
            {
                // TODO: fatal?
                NSLogError(@"When attempting to add persistent store after resetting at path %@: %@", url, error);
            }
        }
    }
    return result;
}

+ (NSURL *)urlOfPersistentStore:(NSString *)nameOfPersistentStore
{
    return [self urlOfPersistentStore:nameOfPersistentStore inUserDirectory:NSDocumentDirectory];
}

+ (NSURL *)urlOfPersistentStore:(NSString *)nameOfPersistentStore inUserDirectory:(NSSearchPathDirectory)userDirectory
{
    NSString *pathComponent = [NSString stringWithFormat:@"%@.sqlite", nameOfPersistentStore];
    return [ [ [ [NSFileManager defaultManager] URLsForDirectory:userDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:pathComponent];
}

+ (NSDictionary *)persistentStoreMetadata:(NSString *)storeType atURL:(NSURL *)url
{
    NSError *error;
    NSDictionary *result = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:storeType
                                                                                      URL:url
                                                                                    error:&error];
    if (error)
    {
        NSLogError(@"When retrieving metadata for persistent store of type %@ at path %@: %@", storeType, url, error);
    }
    
    return result;
}

- (BOOL)addSQLitePersistentStoreAtPath:(NSURL *)url
{
    NSDictionary *options = @{
                              };
    
    BOOL result = NO;
    
    NSError *error;
#if USE_RESTKIT
    NSString *persistentStoreFullPath = [CoreDataStore persistentStoreFullPathString:url];
    
    result = [self.rkObjectManager.managedObjectStore addSQLitePersistentStoreAtPath:persistentStoreFullPath
                                                              fromSeedDatabaseAtPath:nil
                                                                   withConfiguration:nil
                                                                             options:options
                                                                               error:&error];
#else
    self.persistentStore = [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                         configuration:nil
                                                                                   URL:url
                                                                               options:options
                                                                                 error:&error];
    result = self.persistentStore != nil;
    
#endif
    if (error)
    {
        NSLogError(@"When attempting to add SQLite persistent store at path %@: %@", url, error);
    }

    return result;
}

- (BOOL)initInMemoryStore
{
    NSError *error = [self addInMemoryPersistentStore];
    if (error)
    {
        NSLogError(@"When attempting to add in memory persistent store: %@", error);
    }
    return error == nil;
}

- (NSError *)addInMemoryPersistentStore
{
    NSError *result;
#if USE_RESTKIT
    [self.rkObjectManager.managedObjectStore addInMemoryPersistentStore:&result];
#else
    [self.persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType
                                                  configuration:nil
                                                            URL:nil
                                                        options:nil
                                                          error:&result];
#endif
    return result;
}

- (void)createManagedObjectContexts:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
#if USE_RESTKIT
    [self.rkObjectManager.managedObjectStore createManagedObjectContexts];
#else
    self.mainQueueManagedObjectContext = [ [NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainQueueManagedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
#endif
}

#if !(USE_RESTKIT==1)
@synthesize mainQueueManagedObjectContext = _mainQueueManagedObjectContext;

- (void)setMainQueueManagedObjectContext:(NSManagedObjectContext *)mainQueueManagedObjectContext
{
    _mainQueueManagedObjectContext = mainQueueManagedObjectContext;
}
#endif

- (NSManagedObjectContext *)mainQueueManagedObjectContext
{
    NSManagedObjectContext *result;
#if USE_RESTKIT
    result = self.rkObjectManager.managedObjectStore.mainQueueManagedObjectContext;
#else
    result = _mainQueueManagedObjectContext;
#endif
    
    return result;
}

- (BOOL)optionallyCreateManagedObjectContexts:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    BOOL result = NO;
    if (persistentStoreCoordinator.persistentStores.count > 0)
    {
        [self createManagedObjectContexts:persistentStoreCoordinator];
        
        result = YES;
    } else
    {
        result = NO;
    }
    
    return result;
}

#pragma mark Utility

- (NSEntityDescription *)entityDescriptionForEntityName:(NSString *)name
{
    return [ [self.managedObjectModel entitiesByName] objectForKey:name];
}

- (NSFetchedResultsController *)fetchedResultsController:(NSFetchRequest *)fetchResults
{
    return [ [NSFetchedResultsController alloc] initWithFetchRequest:fetchResults
                                                managedObjectContext:[self mainQueueManagedObjectContext]
                                                  sectionNameKeyPath:nil
                                                           cacheName:nil];
}

- (NSFetchedResultsController *)fetchedResultsControllerWithEntityName:(NSString *)entityName andPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName ];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = @[ ];
    fetchRequest.includesSubentities = YES;
    //#if DEBUG
    //    fetchRequest.returnsObjectsAsFaults = NO;
    //#endif
    
    return [self fetchedResultsController:fetchRequest];
}

- (id)insertNewInstance:(Class)ofClass withEntityName:(NSString *)entityName
{
    id result;
    
    NSEntityDescription *description = [self entityDescriptionForEntityName:entityName];
    if (description)
    {
        if ( [ofClass isSubclassOfClass:[NSManagedObject class] ] )
        {
            result = [ [ofClass alloc] initWithEntity:description insertIntoManagedObjectContext:[self mainQueueManagedObjectContext] ];
        } else
        {
            NSLogError(@"Unable to create new instance of %@ with entity name %@, class is not a subclass of NSManagedObject", ofClass, entityName);
        }
    } else
    {
        NSLogError(@"Unable to create new instance of %@ with entity name %@, could not find its description in our managed object model", ofClass, entityName);
    }
    
    return result;
}

- (id)insertNewInstance:(Class<CoreDataStoreObject>)coreDataStoreObject
{
    return [self insertNewInstance:coreDataStoreObject withEntityName:[coreDataStoreObject entityName] ];
}


#pragma mark RestKit

#if USE_RESTKIT
- (id)object:(Class<RestKitDataStoreModel>)objectClass JSONData:(NSData *)jsonData
{
    id object;
    
    if (objectClass)
    {
        object = [objectClass objectWithJSONData:jsonData
                                       inContext:self.rkObjectManager.managedObjectStore.mainQueueManagedObjectContext
                                       withCache:self.rkObjectManager.managedObjectStore.managedObjectCache];
    }
    
    return object;
}

- (void)addRequestDescriptors:(NSArray *)requestDescriptors
{
    if (requestDescriptors.count > 0)
    {
        [self.rkObjectManager addRequestDescriptorsFromArray:requestDescriptors];
    }
}

- (void)addResponseDescriptors:(NSArray *)responseDescriptors
{
    if (responseDescriptors.count > 0)
    {
        [self.rkObjectManager addResponseDescriptorsFromArray:responseDescriptors];
    }
}

- (NSArray *)getRequestDescriptors
{
    return @[
             [SyncedModel requestDescriptor]
             ];
}

- (NSArray *)getResponseDescriptors
{
    return @[
             [SyncedModel responseDescriptor]
             ];
}

- (void)addRequestDescriptor:(RKRequestDescriptor *)requestDescriptor
{
    [self.rkObjectManager addRequestDescriptor:requestDescriptor];
}

- (void)addResponseDescriptor:(RKResponseDescriptor *)responseDescriptor
{
    [self.rkObjectManager addResponseDescriptor:responseDescriptor];
}

- (RKResponseDescriptor *)getResponseDescriptorForKeyPath:(NSString *)keyPath
{
    __block RKResponseDescriptor *result;
    [self.rkObjectManager.responseDescriptors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ( [obj isKindOfClass:[RKResponseDescriptor class] ] )
         {
             RKResponseDescriptor *test = obj;
             if ( [ [test keyPath] isEqualToString:keyPath] )
             {
                 result = test;
             }
         }
     } ];
    return result;
}

- (RKResponseDescriptor *)getResponseDescriptorForPathPattern:(NSString *)pathPattern
{
    __block RKResponseDescriptor *result;
    [self.rkObjectManager.responseDescriptors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ( [obj isKindOfClass:[RKResponseDescriptor class] ] )
         {
             RKResponseDescriptor *test = obj;
             if ( [ [test pathPattern] isEqualToString:pathPattern] )
             {
                 result = test;
             }
         }
     } ];
    return result;
}

- (void)postObject:(id<RestKitDataStoreModel>)object
        parameters:(NSDictionary *)parameters
           success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
           failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    [self.rkObjectManager postObject:object
                                path:[ [object class] keyPath]
                          parameters:nil
                             success:success
                             failure:failure];
}
#endif


#pragma mark Bundle Data

// TODO: find better place?
- (void)retrieveBundleDataWithFileName:(NSString *)fileName resultsHandler:(void(^)(NSData *bundleData) )handleBundleData
{
    NSString *fullPath = [ [NSBundle mainBundle] pathForResource:fileName ofType:@""];
    
    if (fullPath.length > 0)
    {
        NSError *error;
        
        NSData *bundleData = [NSData dataWithContentsOfFile:fullPath
                                                    options:0
                                                      error:&error];
        if (error)
        {
            NSLogError(@"When attempting to load data from filename %@", fileName);
        }
        
        if (handleBundleData)
        {
            handleBundleData(bundleData);
        }
    } else
    {
        NSLogError(@"Unable to retrieve bundle data, cannot find file %@", fileName);
    }
}

#if USE_RESTKIT
// TODO: properly name and delegate checking vs loading vs applying
- (void)checkBundleData:(NSString *)fileName rootClass:(Class<RestKitDataStoreModel>)rootClass
{
    [self retrieveBundleDataWithFileName:fileName
                          resultsHandler:^(NSData *bundleData)
     {
         // TODO: OPT retrieve version without parsing entirety of Content Model
         /*ContentModel *bundleContentModel = */
         NSManagedObject *result = [self object:rootClass JSONData:bundleData];
         NSError *error;
         [result.managedObjectContext save:&error];
         if (error)
         {
             NSLogError(@"When saving bundle data to context: %@", error);
         } else
         {
             [result.managedObjectContext saveToPersistentStore:&error];
             if (error)
             {
                 NSLogError(@"When saving bundle data to persistent store: %@", error);
             }
         }
         // TODO: FIX: above loads bundle data into managed object store, no way to do with below. Looks like it's going to have to be two RKObjectManagers to compare versions, sillyyy...
         
         /*[self retrieveContentModel:^(ContentModel *storeContentModel)
          {
          BOOL update = NO;
          
          if (!storeContentModel)
          {
          update = YES;
          NSLogInfo(@"No previous ContentModel found, using bundle data");
          } else if( [ContentDataStore compareVersion:storeContentModel.version toVersion:bundleContentModel.version] < 0 )
          {
          update = YES;
          NSLogInfo(@"Bundle ContentModel version is newer than previous ContentModel, updating with bundle data");
          }
          if (update)
          {
          [self.rkObjectManager.managedObjectStore.mainQueueManagedObjectContext insertObject:bundleContentModel];
          }
          }];*/
     }];
}
#endif

@end
