//
//  UIImagePickerController+Utility.h
//  Eunomia
//
//  Created by Ian on 2/20/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (Eunomia_Utility)

@property (copy) void(^didFinishPickingMediaWithInfo)(UIImagePickerController *picker, NSDictionary *info);
@property (copy) void(^didCancel)(UIImagePickerController *picker);


@end
