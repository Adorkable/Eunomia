//
//  NSBundle+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 7/28/14.
//  
//

#import "NSBundle+Utility.h"

@implementation NSBundle (Eunomia_Utility)

+ (NSBundle *)bundleWithName:(NSString *)name
{
    NSBundle *result;
    for (id object in [NSBundle allFrameworks] )
    {
        if ( [object isKindOfClass:[NSBundle class] ] )
        {
            NSBundle *bundle = object;
            NSURL *bundleURL = [bundle bundleURL];
            NSArray *bundlePathComponents = [bundleURL pathComponents];
            if (bundlePathComponents.count > 0 && [ [bundlePathComponents objectAtIndex:bundlePathComponents.count - 1] isKindOfClass:[NSString class] ] )
            {
                NSString *fileName = [bundlePathComponents objectAtIndex:bundlePathComponents.count - 1];
                if ( [fileName isEqualToString:name] )
                {
                    result = bundle;
                    break;
                }
            }
        }
    }
    return result;
}

+ (NSBundle *)firstBundleInArray:(NSArray *)array withResource:(NSString *)name withExtension:(NSString *)ext
{
    NSBundle *result;
    for (id object in array)
    {
        if ( [object isKindOfClass:[NSBundle class] ] )
        {
            NSBundle *bundle = object;
            NSURL *url = [bundle URLForResource:name withExtension:ext];
            if (url)
            {
                result = bundle;
                break;
            }
        }
    }
    return result;
}


+ (NSBundle *)firstBundleWithResource:(NSString *)name withExtension:(NSString *)ext
{
    NSBundle *result;
    result = [self firstBundleInArray:[NSBundle allBundles] withResource:name withExtension:ext];
    if (!result)
    {
        result = [self firstBundleInArray:[NSBundle allFrameworks] withResource:name withExtension:ext];
    }
    
    return result;
}

+ (NSURL *)URLForFirstBundleWithResource:(NSString *)name withExtension:(NSString *)ext
{
    NSBundle *bundle = [self firstBundleWithResource:name withExtension:ext];
    return [bundle bundleURL];
}

+ (NSURL *)URLInFirstBundleForResource:(NSString *)name withExtension:(NSString *)ext
{
    NSBundle *bundle = [self firstBundleWithResource:name withExtension:ext];
    
    return [bundle URLForResource:name withExtension:ext];
}

@end
