//
//  NSLogWrapper.m
//  Eunomia
//
//  Created by Ian on 4/30/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "NSLogWrapper.h"

@implementation NSLogWrapper

+ (void)logWithPrefix:(NSString *)prefix format:(NSString *)format args:(va_list)args
{
    NSString *formatWithPrefix = [NSString stringWithFormat:@"%@: %@", prefix, format];
    
    NSLogv(formatWithPrefix, args);
}

#define NSLogWrapperStatement(name, prefix) \
    + (void)name:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) \
    { \
        va_list args; \
        if (format != nil) \
        { \
            va_start(args, format); \
            [self logWithPrefix:prefix format:format args:args]; \
            va_end(args); \
        } \
    }

NSLogWrapperStatement(debug, @"Debug");
NSLogWrapperStatement(verbose, @"Verbose");
NSLogWrapperStatement(info, @"Info");
NSLogWrapperStatement(warn, @"Warn");
NSLogWrapperStatement(error, @"Error");

//+ (void)debug:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
//{
//    va_list args;
//    va_start(args, format);
//    [self logWithPrefix:@"Debug: " format:format, args];
//    va_end(args);
//}

@end
