//
//  NSLogWrapper.h
//  Eunomia
//
//  Created by Ian on 4/30/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLogWrapper : NSObject

+ (void)setupLogger;

+ (void)verbose:(NSString *)string;
+ (void)verboseWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)verboseWithFileName:(const char*)fileName functionName:(const char*)functionName line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(4,5);

+ (void)debug:(NSString *)string;
+ (void)debugWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)debugWithFileName:(const char*)fileName functionName:(const char*)functionName line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(4,5);

+ (void)info:(NSString *)string;
+ (void)infoWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)infoWithFileName:(const char*)fileName functionName:(const char*)functionName line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(4,5);

+ (void)warning:(NSString *)string;
+ (void)warningWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)warningWithFileName:(const char*)fileName functionName:(const char*)functionName line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(4,5);

+ (void)error:(NSString *)string;
+ (void)errorWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)errorWithFileName:(const char*)fileName functionName:(const char*)functionName line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(4,5);

@end

#define NSLog(frmt, ...) \
    [NSLogWrapper infoWithFunctionName:__PRETTY_FUNCTION__ fileName:__FILE__ format:frmt, ##__VA_ARGS__]

#define NSLogVerbose(frmt, ...) [NSLogWrapper verboseWithFileName:__FILE__ functionName:__PRETTY_FUNCTION__ line:__LINE__ format:frmt, ##__VA_ARGS__]
#define NSLogDebug(frmt, ...)   [NSLogWrapper debugWithFileName:__FILE__ functionName:__PRETTY_FUNCTION__ line:__LINE__ format:frmt, ##__VA_ARGS__]
#define NSLogInfo(frmt, ...)    [NSLogWrapper infoWithFileName:__FILE__ functionName:__PRETTY_FUNCTION__ line:__LINE__ format:frmt, ##__VA_ARGS__]
#define NSLogWarning(frmt, ...) [NSLogWrapper warningWithFileName:__FILE__ functionName:__PRETTY_FUNCTION__ line:__LINE__ format:frmt, ##__VA_ARGS__]
#define NSLogError(frmt, ...)   [NSLogWrapper errorWithFileName:__FILE__ functionName:__PRETTY_FUNCTION__ line:__LINE__ format:frmt, ##__VA_ARGS__]
