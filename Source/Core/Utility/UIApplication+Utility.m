//
//  UIApplication+Utility.m
//  Eunomia
//
//  Created by Ian on 10/20/14.
//  Copyright (c) 2014 Eunomia. All rights reserved.
//

#import "UIApplication+Utility.h"

#import "NSLogWrapper.h"

@implementation UIApplication (Eunomia_Utility)

+ (void)dumpApplicationInformation
{
    NSLogInfo(@"Application Version: %@", [self applicationVersion] );
    NSLogInfo(@"Build Version: %@", [self buildVersion] );
    
#if TARGET_IPHONE_SIMULATOR
    NSLogInfo(@"Simulator build running from: %@", [ [NSBundle mainBundle] bundleURL] );
    NSLogInfo(@"Document folder: %@", [ [NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] );
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
