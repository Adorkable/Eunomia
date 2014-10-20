//
//  UIApplication+Utility.m
//  Eunomia
//
//  Created by Ian on 10/20/14.
//  Copyright (c) 2014 Eunomia. All rights reserved.
//

#import "UIApplication+Utility.h"

#import "Config.h"

@implementation UIApplication (Eunomia_Utility)

+ (void)dumpApplicationInformation
{
    NSLogVerbose(@"Application Version: %@", [self applicationVersion] );
    NSLogVerbose(@"Build Version: %@", [self buildVersion] );
    
#if TARGET_IPHONE_SIMULATOR
    NSLogVerbose(@"Simulator build running from: %@", [ [NSBundle mainBundle] bundleURL] );
    NSLogVerbose(@"Document folder: %@", [ [NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] );
#endif
}

+ (NSString *)applicationVersion
{
    return [ [ [NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)buildVersion
{
    return [ [ [NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)applicationAndBuildVersion
{
    return [NSString stringWithFormat:@"%@_%@", [self applicationVersion], [self buildVersion] ];
}

@end
