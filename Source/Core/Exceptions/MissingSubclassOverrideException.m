//
//  MissingSubclassOverrideException.m
//  Eunomia
//
//  Created by Ian on 8/12/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import "MissingSubclassOverrideException.h"

@implementation MissingSubclassOverrideException

+ (instancetype)exceptionWithClass:(Class)class andSelector:(SEL)selector
{
    NSString *className = NSStringFromClass(class);
    NSString *selectorName = NSStringFromSelector(selector);
    
    NSString *reason = [NSString stringWithFormat:@"%@ missing %@", className, selectorName];
    
    return [ [MissingSubclassOverrideException alloc] initWithName:@"Missing Subclass Override"
                                                            reason:reason
                                                          userInfo:@{
                                                                     @"class" : className,
                                                                     @"selector" : selectorName
                                                                     
                                                                     }];
}

@end
