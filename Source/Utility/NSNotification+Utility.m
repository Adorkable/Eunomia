//
//  NSNotification+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 4/22/14.
//
//

#import "NSNotification+Utility.h"

@implementation NSNotification (Eunomia_Utility)

- (id)objectForInfoKey:(NSString *)key
{
    return [self.userInfo objectForKey:key];
}

@end
