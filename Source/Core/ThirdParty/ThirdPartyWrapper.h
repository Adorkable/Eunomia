//
//  ThirdPartyWrapper.h
//  Eunomia
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDAbstractLogger;

@interface ThirdPartyWrapper : NSObject

- (void)initCocoaLumberjack;
+ (void)addCocoaLumberjackLogger:(DDAbstractLogger *)addLogger;

@end
