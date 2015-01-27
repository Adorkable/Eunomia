//
//  NSLogWrapper.m
//  Eunomia
//
//  Created by Ian on 1/27/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "NSLogWrapper.h"

#import "Eunomia.h"

#import <CocoaLumberjack/CocoaLumberjack.h>

@implementation NSLogWrapper

+ (void)logError:(NSString *)message
{
    NSLogError(@"%@", message);
}

+ (void)logWarn:(NSString *)message
{
    NSLogWarn(@"%@", message);
}

+ (void)logInfo:(NSString *)message
{
    NSLogInfo(@"%@", message);
}

+ (void)logDebug:(NSString *)message
{
    NSLogDebug(@"%@", message);
}

+ (void)logVerbose:(NSString *)message
{
    DDLogVerbose(@"%@", message);
}

@end