//
//  ARAnalytics+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 5/30/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ARAnalytics/ARAnalytics.h>

@interface ARAnalytics (Eunomia_Utility)

+ (void)event:(NSString *)event
 withCategory:(NSString *)category;

+ (void)event:(NSString *)event
 withCategory:(NSString *)category
    withLabel:(NSString *)label;

+ (void)event:(NSString *)event
 withCategory:(NSString *)category
    withValue:(NSNumber *)value;

+ (void)event:(NSString *)event
 withCategory:(NSString *)category
    withLabel:(NSString *)label
     andValue:(NSNumber *)value;

@end
