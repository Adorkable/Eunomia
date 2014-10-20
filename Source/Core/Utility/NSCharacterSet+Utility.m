//
//  NSCharacterSet+Utility.m
//  Eunomia
//
//  Created by Ian on 10/20/14.
//  Copyright (c) 2014 Eunomia. All rights reserved.
//

#import "NSCharacterSet+Utility.h"

@implementation NSCharacterSet (Eunomia_Utility)

- (NSString *)stringWithCharactersInSet
{
    NSMutableString *result = [NSMutableString string];
    
    for (unichar test = 0; test < UCHAR_MAX; test++)
    {
        if ( [self characterIsMember:test] )
        {
            [result appendFormat:@"%c", test];
        }
    }
    
    return result;
}

@end
