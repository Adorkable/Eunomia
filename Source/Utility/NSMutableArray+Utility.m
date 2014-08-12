//
//  NSMutableArray+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/14.
// 
//

#import "NSMutableArray+Utility.h"

@implementation NSMutableArray (Eunomia_Utility)

- (void)addObjectSafe:(id)object
{
    if (object)
    {
        [self addObject:object];
    }
}

@end
