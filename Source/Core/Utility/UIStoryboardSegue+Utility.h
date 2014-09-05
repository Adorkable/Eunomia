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
- (void)performIfViewsWithParentAreAvailableOrReplace:(void(^)(UIViewController *sourceViewController, UIViewController *destinationViewController, UIViewController *parentViewController, UIView *sourceView, UIView *destinationView, UIView *parentView) )performIfViewsAreAvailable;

- (void)notifySegueFinishedAnimating:(id)object;

- (void)doTransferSubviewPrep;
- (void)doTransferSubviewDestinationFrame;
- (void)doTransferSubviewCompleteAnimation;

@end

@protocol AnimatedSegueViewController <NSObject>

@optional
- (void)segueFinishedAnimating:(UIStoryboardSegue *)segue;

@end

@protocol ReplaceSegueSourceViewController <NSObject>

@optional
- (BOOL)replaceSegueSourceShouldTransferSubview:(UIStoryboardSegue *)segue;
- (UIView *)replaceSegueSourceTransferSubview:(UIStoryboardSegue *)segue;

@end

@protocol ReplaceSegueDestinationViewController <NSObject>

@optional
- (BOOL)replaceSegueDestinationShouldTransferSubview:(UIStoryboardSegue *)segue;
- (CGRect)replaceSegueDestinationTransferSubviewDestinationRect:(UIStoryboardSegue *)segue;
- (UIView *)replaceSegueDestinationTransferSubviewDestinationRectRelativeView:(UIStoryboardSegue *)segue;

@end
