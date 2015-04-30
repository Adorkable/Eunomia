//
//  NSLogWrapper.m
//  Eunomia
//
//  Created by Ian on 4/30/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "NSLogWrapper.h"

@implementation NSLogWrapper

+ (void)logWithPrefix:(NSString *)prefix
         functionName:(const char*)functionName
             fileName:(const char*)fileName
               format:(NSString *)format args:(va_list)args
{
    NSMutableString *formatWithInfo = [NSMutableString string];
    
    if (prefix.length > 0)
    {
        [formatWithInfo appendString:prefix];
    }
    
    /*    if (logMessage->_threadName.length > 0)
     {
     [result appendFormat:@" | thrd:%@", logMessage->_threadName];
     }
     if (logMessage->_queueLabel.length > 0)
     {
     [result appendFormat:@" | gcd:%@", logMessage->_queueLabel];
     }
     */
    
    if (format.length > 0)
    {
        [formatWithInfo appendString:@" "];
    }
    [formatWithInfo appendString:@"|"];
    
    if (format.length > 0)
    {
        if (formatWithInfo.length > 0)
        {
            formatWithInfo = [NSMutableString stringWithFormat:@"%@ %@", formatWithInfo, format];
        } else
        {
            [formatWithInfo appendString:format];
        }
    }
    
    if ( (fileName != NULL && strlen(fileName) > 0) || (functionName != NULL && strlen(functionName) > 0) )
    {
        NSString *fileNameString = [NSString stringWithUTF8String:fileName];
        NSString *lastPathComponentString = [fileNameString lastPathComponent];
        NSString *functionNameString = [NSString stringWithUTF8String:functionName];
        
        if (formatWithInfo.length > 0)
        {
            formatWithInfo = [NSMutableString stringWithFormat:@"%@ | {%@: %@}", formatWithInfo, lastPathComponentString, functionNameString];
        } else
        {
            [formatWithInfo appendFormat:@"| {%@: %@}", lastPathComponentString, functionNameString];
        }
    }
    
    NSLogv(formatWithInfo, args);
}

#define NSLogWrapperStatement(name, prefix) \
    + (void)name:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) \
    { \
        va_list args; \
        if (format != nil) \
        { \
            va_start(args, format); \
            [self logWithPrefix:prefix functionName:NULL fileName:NULL format:format args:args]; \
            va_end(args); \
        } \
    } \
    \
    + (void)name##WithFunctionName:(const char*)functionName fileName:(const char*)fileName format:(NSString *)format, ... NS_FORMAT_FUNCTION(3,4) \
    { \
        va_list args; \
        if (format != nil) \
        { \
            va_start(args, format); \
            [self logWithPrefix:prefix functionName:functionName fileName:fileName format:format args:args]; \
            va_end(args); \
        } \
    } \

NSLogWrapperStatement(verbose,  @"V");
NSLogWrapperStatement(debug,    @"D");
NSLogWrapperStatement(info,     @"I");
NSLogWrapperStatement(warning,  @"W");
NSLogWrapperStatement(error,    @"E");

@end
