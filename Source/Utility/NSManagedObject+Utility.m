//
//  NSManagedObject+Utility.m
//  Eunomia
//
//  Created by Ian on 8/18/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import "NSManagedObject+Utility.h"

#import "Eunomia.h"

@implementation NSManagedObject (Eunomia_Utility)

- (void)deleteObject
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    [managedObjectContext deleteObject:self];
}

- (BOOL)deleteAndSaveOrLogError:(NSString *)context
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    [self deleteObject];
    
    return [managedObjectContext saveAndLogError:context];
}

- (BOOL)saveOrLogError:(NSString *)usageContext
{
    return [self.managedObjectContext saveAndLogError:usageContext];
}

@end
