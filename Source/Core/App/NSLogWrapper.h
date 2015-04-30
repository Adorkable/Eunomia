//
//  NSLogWrapper.h
//  Eunomia
//
//  Created by Ian on 4/30/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLogWrapper : NSObject

+ (void)verbose:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)verboseWithFunctionName:(const char*)functionName fileName:(const char*)fileName format:(NSString *)format, ... NS_FORMAT_FUNCTION(3,4);

+ (void)debug:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)debugWithFunctionName:(const char*)functionName fileName:(const char*)fileName format:(NSString *)format, ... NS_FORMAT_FUNCTION(3,4);

+ (void)info:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)infoWithFunctionName:(const char*)functionName fileName:(const char*)fileName format:(NSString *)format, ... NS_FORMAT_FUNCTION(3,4);

+ (void)warning:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)warningWithFunctionName:(const char*)functionName fileName:(const char*)fileName format:(NSString *)format, ... NS_FORMAT_FUNCTION(3,4);

+ (void)error:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)errorWithFunctionName:(const char*)functionName fileName:(const char*)fileName format:(NSString *)format, ... NS_FORMAT_FUNCTION(3,4);

@end

#define NSLog(frmt, ...) [NSLogWrapper infoWithFunctionName:__PRETTY_FUNCTION__ fileName:__FILE__ format:frmt, ##__VA_ARGS__]

#define NSLogVerbose(frmt, ...) [NSLogWrapper verboseWithFunctionName:__PRETTY_FUNCTION__ fileName:__FILE__ format:frmt, ##__VA_ARGS__]
#define NSLogDebug(frmt, ...)   [NSLogWrapper debugWithFunctionName:__PRETTY_FUNCTION__ fileName:__FILE__ format:frmt, ##__VA_ARGS__]
#define NSLogInfo(frmt, ...)    [NSLogWrapper infoWithFunctionName:__PRETTY_FUNCTION__ fileName:__FILE__ format:frmt, ##__VA_ARGS__]
#define NSLogWarning(frmt, ...)    [NSLogWrapper warningWithFunctionName:__PRETTY_FUNCTION__ fileName:__FILE__ format:frmt, ##__VA_ARGS__]
#define NSLogError(frmt, ...)   [NSLogWrapper errorWithFunctionName:__PRETTY_FUNCTION__ fileName:__FILE__ format:frmt, ##__VA_ARGS__]
