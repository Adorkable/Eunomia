//
//  VerboseDDLogFormatter.m
//  Solace
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import "VerboseDDLogFormatter.h"

@implementation VerboseDDLogFormatter

- (NSString *)cocoaLumberjackLogFlagAsString:(int)logFlag
{
    NSString *result;
    switch (logFlag)
    {
        case LOG_FLAG_ERROR :
            result = @"E";
            break;
        case LOG_FLAG_WARN  :
            result = @"W";
            break;
        case LOG_FLAG_INFO  :
            result = @"I";
            break;
        case LOG_FLAG_DEBUG:
            result = @"D";
            break;
        case LOG_FLAG_VERBOSE :
            result = @"V";
            break;
    }
    return result;
}

// TODO: support substring colors?
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSMutableString *result = [NSMutableString string];
    
    NSString *logLevel = [self cocoaLumberjackLogFlagAsString:logMessage->logFlag];
    if ( [logLevel length] > 0)
    {
        [result appendFormat:@"%@", logLevel];
    }
    
    if ( [logMessage->threadName length] > 0)
    {
        [result appendFormat:@" | thrd:%@", logMessage->threadName];
    }
    if ( logMessage->queueLabel != 0 && strlen(logMessage->queueLabel) > 0)
    {
        [result appendFormat:@" | gcd:%s", logMessage->queueLabel];
    }
    
    [result appendFormat:@": %@", logMessage->logMsg];
    
    NSString *file;
    if (logMessage->file != 0 && strlen(logMessage->file) > 0)
    {
        file = [NSString stringWithCString:logMessage->file encoding:NSUTF8StringEncoding];
        file = [NSString stringWithFormat:@"%@:%d:", [file lastPathComponent], logMessage->lineNumber];
    }
    [result appendFormat:@" | [%@%s]", file, logMessage->function ];
    
    return result;
}

@end
