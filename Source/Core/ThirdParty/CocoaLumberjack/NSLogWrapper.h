//
//  NSLogWrapper.h
//  Eunomia
//
//  Created by Ian on 1/27/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://stackoverflow.com/a/24144858
@interface NSLogWrapper : NSObject

+ (void)logError:(NSString *)message;
+ (void)logWarn:(NSString *)message;
+ (void)logInfo:(NSString *)message;
+ (void)logDebug:(NSString *)message;
+ (void)logVerbose:(NSString *)message;

@end
