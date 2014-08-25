//
//  NSManagedObjectContext+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 5/28/14.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Eunomia_Utility)

- (BOOL)saveAndLogError:(NSString *)usageContext; // rename to saveOrLogError

@end
