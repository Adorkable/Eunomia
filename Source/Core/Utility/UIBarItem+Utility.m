//
//  UIBarItem+Utility.m
//  Eunomia
//
//  Created by Ian on 10/20/14.
//  Copyright (c) 2014 Eunomia. All rights reserved.
//

#import "UIBarItem+Utility.h"

@implementation UIBarItem (Eunomia_Utility)

- (UIView *)view
{
    UIView *result;
    
    id object = [self valueForKey:@"view"]; // HACK: >:#
    if ( [object isKindOfClass:[UIView class] ] )
    {
        result = object;
    }
    
    return result;
}

@end
