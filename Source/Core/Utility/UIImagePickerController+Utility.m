//
//  UIImagePickerController+Utility.m
//  Eunomia
//
//  Created by Ian on 2/20/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "UIImagePickerController+Utility.h"

#import "NSObject+Utility.h"

@interface UIImagePickerControllerDelegate : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (copy) void(^didFinishPickingMediaWithInfo)(UIImagePickerController *picker, NSDictionary *info);
@property (copy) void(^didCancel)(UIImagePickerController *picker);

@end

@interface UIImagePickerController (Eunomia_Utility_Private)

@property (retain) UIImagePickerControllerDelegate *delegateWrapper;

@end

@implementation UIImagePickerController (Eunomia_Utility)

- (void)setupDelegateWrapper
{
    self.delegateWrapper = [ [UIImagePickerControllerDelegate alloc] init];
    self.delegate = self.delegateWrapper;
}

- (void)setDelegateWrapper:(UIImagePickerControllerDelegate *)delegateWrapper
{
    [self setProtocolRetainProperty:@selector(delegateWrapper) value:delegateWrapper];
}

- (UIImagePickerControllerDelegate *)delegateWrapper
{
    return [self getProtocolProperty:@selector(delegateWrapper) ];
}

- (void)setDidFinishPickingMediaWithInfo:(void (^)(UIImagePickerController *, NSDictionary *))didFinishPickingMediaWithInfo
{
    if (!self.delegateWrapper)
    {
        [self setupDelegateWrapper];
    }
    
    self.delegateWrapper.didFinishPickingMediaWithInfo = didFinishPickingMediaWithInfo;
}

- (void(^)(UIImagePickerController *, NSDictionary *) )didFinishPickingMediaWithInfo
{
    return self.delegateWrapper.didFinishPickingMediaWithInfo;
}

- (void)setDidCancel:(void (^)(UIImagePickerController *))didCancel
{
    if (!self.delegateWrapper)
    {
        [self setupDelegateWrapper];
    }
    self.delegateWrapper.didCancel = didCancel;
}

- (void(^)(UIImagePickerController *) )didCancel
{
    return self.delegateWrapper.didCancel;
}

@end

@implementation UIImagePickerControllerDelegate

// TODO: UINavigationControllerDelegate support
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.didFinishPickingMediaWithInfo)
    {
        self.didFinishPickingMediaWithInfo(picker, info);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.didCancel)
    {
        self.didCancel(picker);
    }
}

@end
