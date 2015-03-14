//
//  UIDevice+Utility.h
//  Eunomia
//
//  Created by Ian on 3/14/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Eunomia_Utility)

- (BOOL)isSimulator;

- (NSString *)vendorUUIDString;

@end
