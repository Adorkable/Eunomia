//
//  ThirdPartyWrapper.m
//  Eunomia
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import "ThirdPartyWrapper.h"

#import "Config.pch"

#import "VerboseDDLogFormatter.h"

#import <UIKit/UIKit.h>

#pragma mark Library Headers

#if DEBUG
#import <CocoaLumberjack/DDTTYLogger.h>
#endif

#if USE_NSLOGGER
#import <NSLogger/LoggerClient.h>
#import <NSLogger-CocoaLumberjack-connector/DDNSLoggerLogger.h>
#endif

#if USE_CRASHLYTICS
#import <CrashlyticsFramework/Crashlytics.h>
#import <CrashlyticsLumberjack/CrashlyticsLogger.h>
#endif

#if USE_TEST_FLIGHT
#import <TestFlightSDK/TestFlight.h>
#import <TestFlightLogger/TestFlightLogger.h>
#endif

#if USE_ARANALYTICS
#import <ARAnalytics/ARAnalytics.h>
#endif

#if USE_PONYDEBUGGER
#import <PonyDebugger/PonyDebugger.h>
#endif

#if USE_LOOKBACK
#import <Lookback/Lookback.h>
#endif

@implementation ThirdPartyWrapper

+ (NSString *)vendorUUIDString
{
    return [ [ [UIDevice currentDevice] identifierForVendor] UUIDString];
}

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

- (void)initNSLogger
{
#if USE_NSLOGGER
    [ThirdPartyWrapper addCocoaLumberjackLogger:[DDNSLoggerLogger sharedInstance] ];
    
    NSLogInfo(@"NSLogger initialized");
#endif
}

- (void)initCrashlyticsWithAPIKey:(NSString *)apiKey
{
#if USE_CRASHLYTICS
    [Crashlytics startWithAPIKey:apiKey];
    
    [ThirdPartyWrapper addCocoaLumberjackLogger:[CrashlyticsLogger sharedInstance] ];
    
    NSLogInfo(@"Crashlytics initialized");
#endif
}

- (void)initTestFlightWithAppToken:(NSString *)appToken
{
#if USE_TEST_FLIGHT
#if USE_CRASHLYTICS
    [TestFlight setOptions:@{
                             TFOptionReportCrashes: @NO
                             } ];
#endif
    [TestFlight takeOff:appToken];
    
    [ThirdPartyWrapper addCocoaLumberjackLogger:[TestFlightLogger sharedInstance] ];
    
    NSLogInfo(@"Test Flight initialized");
#endif
}

- (void)initARAnalyticsWithTokens:(NSDictionary *)initTokens
{
#if USE_ARANALYTICS
    [ARAnalytics setupWithAnalytics:initTokens];
    
    NSLogInfo(@"ARAnalyics initialized");
#endif
}

- (void)initPonyDebugger
{
#if USE_PONYDEBUGGER
    PDDebugger *ponyDebugger = [PDDebugger defaultInstance];
    [ponyDebugger autoConnect];
    
    [ponyDebugger enableNetworkTrafficDebugging];
    [ponyDebugger forwardAllNetworkTraffic];
    [ponyDebugger enableViewHierarchyDebugging];
    
    NSLogInfo(@"Pony Debugger initialized");
#endif
}

- (void)initPonyDebuggerCodeDataDebugging:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name
{
#if USE_PONYDEBUGGER
    PDDebugger *ponyDebugger = [PDDebugger defaultInstance];
    
    [ponyDebugger enableCoreDataDebugging];
    [ponyDebugger addManagedObjectContext:managedObjectContext withName:name];
    
    NSLogInfo(@"PonyDebugger Code Data initialized for context %@", name);
#endif
}

- (void)initLookback:(NSString *)appToken
{
#if USE_LOOKBACK
    [Lookback_Weak setupWithAppToken:appToken];
    [Lookback_Weak lookback].shakeToRecord = YES;
#endif
}

- (void)setUserEmail:(NSString *)userEmail
{
#if USE_CRASHLYTICS
    [Crashlytics setUserEmail:userEmail];
#endif
    
#if USE_TEST_FLIGHT
    [TestFlight addCustomEnvironmentInformation:userEmail forKey:@"userEmail"];
#endif
    
#if USE_ARANALYTICS
    [ARAnalytics identifyUserWithID:[ThirdPartyWrapper vendorUUIDString] andEmailAddress:userEmail];
#endif
    
#if USE_LOOKBACK
    [Lookback_Weak lookback].userIdentifier = userEmail;
#endif
}

@end