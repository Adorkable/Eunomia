//
//  ALAssetsLibrary+Utility.m
//  Eunomia
//
//  Created by Ian on 2/20/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "ALAssetsLibrary+Utility.h"

#import "NSLogWrapper.h"

@implementation ALAssetsLibrary (Eunomia_Utility)

+ (void)firstImage:(void(^)(UIImage *firstImage) )handler
{
    // http://stackoverflow.com/questions/10200553/how-to-retrieve-the-most-recent-photo-from-camera-roll-on-ios
    ALAssetsLibrary *assetsLibrary = [ [ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                 usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         if (group != nil)
         {
             [group setAssetsFilter:[ALAssetsFilter allPhotos] ];
             
             [group enumerateAssetsWithOptions:NSEnumerationReverse
                                    usingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop)
             {
                 if (asset != nil)
                 {
                     ALAssetRepresentation *repr = [asset defaultRepresentation];
                     UIImage *image = [UIImage imageWithCGImage:[repr fullResolutionImage]];
                     
                     if (handler)
                     {
                         handler(image);
                     }
                     
                     *stop = YES;
                 }
             }];
         }
         
         *stop = NO;
     } failureBlock:^(NSError *error) {
         [NSLogWrapper error:@"When retrieving firstImage: %@", error];
     } ];
}

@end
