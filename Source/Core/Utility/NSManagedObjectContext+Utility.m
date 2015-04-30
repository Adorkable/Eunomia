//
//  NSManagedObjectContext+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 5/28/14.
//

#import "NSManagedObjectContext+Utility.h"

#import "NSLogWrapper.h"

@implementation NSManagedObjectContext (Eunomia_Utility)

- (BOOL)saveAndLogError:(NSString *)usageContext
{
    NSError *error;
    [self save:&error];
    if (error)
    {
        [NSLogWrapper error:@"%@: %@", usageContext, error];
    }
    
    return error != nil;
}

@end
