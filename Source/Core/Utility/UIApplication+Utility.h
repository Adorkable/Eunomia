//
//  UIApplication+Utility.h
//  Eunomia
//
//  Created by Ian on 10/20/14.
//  Copyright (c) 2014 Eunomia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Eunomia_Utility)

+ (void)dumpApplicationInformation;

+ (NSString *)applicationVersion;
+ (NSString *)buildVersion;
+ (NSString *)applicationAndBuildVersion;

@end
