//
//  Config.h
//  Eunomia
//
//  Created by Ian Grossberg on 7/3/14.
//
//

#pragma once

#import <CocoaLumberjack/CocoaLumberjack.h>

#define NSLog(frmt, ...)           DDLogInfo(frmt, ##__VA_ARGS__)
#define NSLogError(frmt, ...)      DDLogError(frmt, ##__VA_ARGS__)
#define NSLogWarn(frmt, ...)       DDLogWarn(frmt, ##__VA_ARGS__)
#define NSLogInfo(frmt, ...)       DDLogInfo(frmt, ##__VA_ARGS__)
#define NSLogDebug(frmt, ...)      DDLogDebug(frmt, ##__VA_ARGS__)
#define NSLogVerbose(frmt, ...)    DDLogVerbose(frmt, ##__VA_ARGS__)

#define DefineProtocolProperty(Type, Name) \
- (void)set##Name:(Type *)value \
{ \
    [self setProtocolRetainProperty:@selector(get##Name) value:value]; \
} \
\
- (Type *)get##Name \
{ \
    Type *result; \
    id object = [self getProtocolProperty:@selector(get##Name)]; \
    if ( [object isKindOfClass:[Type class] ] ) \
    { \
        result = object; \
    } \
    return result; \
}