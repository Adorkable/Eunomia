//
//  VerboseDDLogFormatter.m
//  Solace
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import "VerboseDDLogFormatter.h"

#import <CocoaLumberjack/CocoaLumberjack.h>

@implementation VerboseDDLogFormatter

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
    [result appendFormat:@" | [%@%@]", file, logMessage->_function];
    
    return result;
}

@end
