//
//  NSManagedObject+Utility.h
//  Eunomia
//
//  Created by Ian on 8/18/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Eunomia_Utility)

- (void)deleteObject;
- (BOOL)deleteAndSaveOrLogError:(NSString *)context;

- (BOOL)saveOrLogError:(NSString *)usageContext;

@end
