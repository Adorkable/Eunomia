//
//  ThirdPartyWrapper.h
//  Eunomia
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface ThirdPartyWrapper : NSObject

- (void)initCocoaLumberjack;
- (void)initNSLogger;
- (void)initCrashlyticsWithAPIKey:(NSString *)apiKey;
- (void)initTestFlightWithAppToken:(NSString *)appToken;
- (void)initARAnalyticsWithTokens:(NSDictionary *)initTokens;

- (void)initPonyDebugger;
- (void)initPonyDebuggerCodeDataDebugging:(NSManagedObjectContext *)managedObjectContext withName:(NSString *)name;

- (void)initLookback:(NSString *)appToken;

- (void)setUserEmail:(NSString *)userEmail;

@end
