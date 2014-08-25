//
//  Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 3/12/14.
//
//

#import "Utility.h"

CGFloat randomf()
{
    return (CGFloat)randomi() / (CGFloat)UINT32_MAX * 1.0f;
}

u_int32_t randomi()
{
    return arc4random();
}