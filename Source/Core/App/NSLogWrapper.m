//
//  NSLogWrapper.m
//  Eunomia
//
//  Created by Ian on 4/30/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "NSLogWrapper.h"

#import <CocoaLumberjack/CocoaLumberjack.h>

@interface EunomiaCocoaLumberjackFormatter : NSObject< DDLogFormatter >

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage;

@end

@implementation NSLogWrapper

+ (void)setupLogger;
{
    EunomiaCocoaLumberjackFormatter *logFormatter = [ [EunomiaCocoaLumberjackFormatter alloc] init];
    
    [ [DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.973f green:0.153f blue:0.218f alpha:1.000] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagError];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.870f green:0.825f blue:0.254f alpha:1.000] backgroundColor:[UIColor colorWithWhite:1.000 alpha:1.000] forFlag:DDLogFlagWarning];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithWhite:0.212f alpha:1.000] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagInfo];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.391f green:0.520f blue:0.417f alpha:1.000] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagDebug];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithWhite:0.675f alpha:1.000] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagVerbose];
    [ [DDTTYLogger sharedInstance] setLogFormatter:logFormatter];
    
    [DDLog addLogger:[DDTTYLogger sharedInstance] ];
}

#define NSLogWrapperStatement(lowerName, UpperName) \
+ (void)lowerName:(NSString *)string \
{ \
    [DDLog log:NO \
       message:string \
         level:DDLogLevel##UpperName \
          flag:DDLogFlag##UpperName \
       context:0 \
          file:NULL \
      function:NULL \
          line:0 \
           tag:nil]; \
} \
\
+ (void)lowerName##WithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1, 2) \
{ \
    va_list args; \
    if (format != nil) \
    { \
        va_start(args, format); \
        \
        [DDLog log:NO \
             level:DDLogLevel##UpperName \
              flag:DDLogFlag##UpperName \
           context:0 \
              file:NULL \
          function:NULL \
              line:0 \
               tag:nil \
            format:format \
              args:args]; \
        \
        va_end(args); \
    } \
} \
\
+ (void)lowerName##WithFileName:(const char *)fileName functionName:(const char *)functionName line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(4, 5) \
{ \
    va_list args; \
    if (format != nil) \
    { \
        va_start(args, format); \
        \
        [DDLog log:NO \
             level:DDLogLevel##UpperName \
              flag:DDLogFlag##UpperName \
           context:0 \
              file:fileName \
          function:functionName \
              line:0 \
               tag:nil \
            format:format \
              args:args]; \
        \
        va_end(args); \
    }\
}

NSLogWrapperStatement(verbose, Verbose);
NSLogWrapperStatement(debug, Debug);
NSLogWrapperStatement(info, Info);
NSLogWrapperStatement(warning, Warning);
NSLogWrapperStatement(error,  Error);

@end

@implementation EunomiaCocoaLumberjackFormatter

- (NSString *)cocoaLumberjackLogFlagAsString:(int)logFlag
{
    NSString *result;
    switch (logFlag)
    {
        case DDLogFlagError :
            result = @"E";
            break;
        case DDLogFlagWarning  :
            result = @"W";
            break;
        case DDLogFlagInfo  :
            result = @"I";
            break;
        case DDLogFlagDebug:
            result = @"D";
            break;
        case DDLogFlagVerbose :
            result = @"V";
            break;
    }
    return result;
}

// TODO: support substring colors?
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSMutableString *result = [NSMutableString string];
    
    NSString *logLevel = [self cocoaLumberjackLogFlagAsString:logMessage->_flag];
    if (logLevel.length > 0)
    {
        [result appendFormat:@"%@", logLevel];
    }
    
    if (logMessage->_threadName.length > 0)
    {
        [result appendFormat:@" | thrd:%@", logMessage->_threadName];
    }
    if (logMessage->_queueLabel.length > 0)
    {
        [result appendFormat:@" | gcd:%@", logMessage->_queueLabel];
    }
    
    [result appendFormat:@": %@", logMessage->_message];
    
    NSString *file;
    if (logMessage->_file.length > 0)
    {
        file = [NSString stringWithFormat:@"%@:%lu:", [logMessage->_file lastPathComponent], (unsigned long)logMessage->_line];
    }
    [result appendFormat:@" | {%@%@}", file, logMessage->_function];
    
    return result;
}

@end