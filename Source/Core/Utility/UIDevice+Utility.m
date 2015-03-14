//
//  UIDevice+Utility.m
//  Eunomia
//
//  Created by Ian on 3/14/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "UIDevice+Utility.h"

@implementation UIDevice (Eunomia_Utility)

- (BOOL)isSimulator
{
    return [self.model isEqualToString:@"iPhone Simulator"];
}

- (NSString *)vendorUUIDString
{
    return self.identifierForVendor.UUIDString;
}

@end
