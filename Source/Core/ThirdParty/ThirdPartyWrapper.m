//
//  ThirdPartyWrapper.m
//  Eunomia
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import "ThirdPartyWrapper.h"

#import "Config.h"

#import "VerboseDDLogFormatter.h"

#import <UIKit/UIKit.h>

#pragma mark Library Headers

#if DEBUG
#import "DDTTYLogger.h"
#endif

@implementation ThirdPartyWrapper

+ (void)addCocoaLumberjackLogger:(DDAbstractLogger *)addLogger
{
#if USE_NSLOGGER // NSLogger's protocol handles all the metadata itself
    if (![addLogger isKindOfClass:[DDNSLoggerLogger class] ] )
    {
#endif
        [addLogger setLogFormatter:[ [VerboseDDLogFormatter alloc] init] ];
#if USE_NSLOGGER
    }
#endif
    
    [DDLog addLogger:addLogger];
}

- (void)initCocoaLumberjack
{
#if DEBUG
    [ThirdPartyWrapper addCocoaLumberjackLogger:[DDTTYLogger sharedInstance] ];
    
    [ [DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.973f green:0.153f blue:0.218f alpha:1.000] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagError];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.870f green:0.825f blue:0.254f alpha:1.000] backgroundColor:[UIColor colorWithWhite:1.000 alpha:1.000] forFlag:DDLogFlagWarning];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithWhite:0.212f alpha:1.000] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagInfo];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.391f green:0.520f blue:0.417f alpha:1.000] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagDebug];
    [ [DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithWhite:0.675f alpha:1.000] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagVerbose];
#endif
    
    NSLogInfo(@"CocoaLumberjack initialized");
}

@end