//
//  UIStoryboardSegue+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/14/14.
//
//

#import <UIKit/UIKit.h>

@interface UIStoryboardSegue (Eunomia_Utility)

@property (nonatomic, readonly) UIViewController *sourceViewControllerTyped;
@property (nonatomic, readonly) UIViewController *destinationViewControllerTyped;

- (void)performIfViewsAreAvailableOrReplace:(void(^)(UIViewController *sourceViewController, UIViewController *destinationViewController, UIView *sourceView, UIView *destinationView) )performIfViewsAreAvailable;

@end
