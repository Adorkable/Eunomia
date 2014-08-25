//
//  MissingSubclassOverrideException.h
//  Eunomia
//
//  Created by Ian on 8/12/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MissingSubclassOverrideException : NSException

+ (instancetype)exceptionWithClass:(Class)class andSelector:(SEL)selector;

@end
