//
//  ALAssetsLibrary+Utility.h
//  Eunomia
//
//  Created by Ian on 2/20/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface ALAssetsLibrary (Eunomia_Utility)

+ (void)firstImage:(void(^)(UIImage *firstImage) )handler;

@end
