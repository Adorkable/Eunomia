//
//  NSBundle+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 7/28/14.
//  
//

#import <Foundation/Foundation.h>

@interface NSBundle (Eunomia_Utility)

+ (NSBundle *)bundleWithName:(NSString *)name;

+ (NSBundle *)firstBundleWithResource:(NSString *)name withExtension:(NSString *)ext;
+ (NSURL *)URLForFirstBundleWithResource:(NSString *)name withExtension:(NSString *)ext;
+ (NSURL *)URLInFirstBundleForResource:(NSString *)name withExtension:(NSString *)ext;

@end
