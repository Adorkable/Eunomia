//
//  NSLogWrapper.h
//  Eunomia
//
//  Created by Ian on 4/30/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLogWrapper : NSObject

+ (void)debug:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)verbose:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)info:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)warn:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)error:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

@end
