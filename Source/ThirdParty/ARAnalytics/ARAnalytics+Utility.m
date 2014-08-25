//
//  ARAnalytics+Utility.m
//  Solace
//
//  Created by Ian Grossberg on 5/30/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import "ARAnalytics+Utility.h"

#import <ARAnalytics/ARAnalytics+GoogleAnalytics.h>

@implementation ARAnalytics (Eunomia_Utility)

+ (void)event:(NSString *)event
 withCategory:(NSString *)category {
    [self event:event withProperties:[ARAnalytics dictionaryWithCategory:category] ];
}

+ (void)event:(NSString *)event
 withCategory:(NSString *)category
    withLabel:(NSString *)label {
    [self event:event withProperties:[ARAnalytics dictionaryWithCategory:category withLabel:label] ];
}

+ (void)event:(NSString *)event
 withCategory:(NSString *)category
    withValue:(NSNumber *)value {
    [self event:event withProperties:[ARAnalytics dictionaryWithCategory:category withLabel:nil withValue:value] ];
}

+ (void)event:(NSString *)event
 withCategory:(NSString *)category
    withLabel:(NSString *)label
     andValue:(NSNumber *)value {
    [self event:event withProperties:[ARAnalytics dictionaryWithCategory:category withLabel:label withValue:value] ];
}

@end
