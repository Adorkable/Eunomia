//
//  Config.h
//  Eunomia
//
//  Created by Ian Grossberg on 7/3/14.
//
//

#pragma once

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <SegueingInfo/SegueingInfo.h>

#if DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelInfo;
#endif
#define ddLogLevelInitialized

#define NSLog(frmt, ...)           DDLogInfo(frmt, ##__VA_ARGS__)
#define NSLogError(frmt, ...)      DDLogError(frmt, ##__VA_ARGS__)
#define NSLogWarn(frmt, ...)       DDLogWarn(frmt, ##__VA_ARGS__)
#define NSLogInfo(frmt, ...)       DDLogInfo(frmt, ##__VA_ARGS__)
#define NSLogDebug(frmt, ...)      DDLogDebug(frmt, ##__VA_ARGS__)
#define NSLogVerbose(frmt, ...)    DDLogVerbose(frmt, ##__VA_ARGS__)