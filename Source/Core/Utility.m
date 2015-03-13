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

CGSize CGSizeMinusCGSize(CGSize left, CGSize right)
{
    return CGSizeMake(left.width - right.width, left.height - right.height);
}

CGSize CGSizeMultiplied(CGSize size, CGFloat multiplier)
{
    return CGSizeMake(size.width * multiplier, size.height * multiplier);
}

CGPoint CGPointMakeScaled(CGFloat width, CGFloat height, CGFloat scale)
{
    return CGPointMake(width * scale, height * scale);
}

NSString *GetAppDocumentPath()
{
    NSString *result;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (paths.count > 0)
    {
        result = paths[0];
    }
    
    return result;
}

NSString *GetAppLibraryPath()
{
    NSString *result;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if (paths.count > 0)
    {
        result = paths[0];
    }
    
    return result;
}