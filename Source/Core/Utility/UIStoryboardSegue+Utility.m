//
//  UIStoryboardSegue+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/14/14.
//
//

#import "UIStoryboardSegue+Utility.h"

#import "UIViewController+Utility.h"

#import "NSObject+Utility.h"

#import "Config.pch"

NSString *const Eunomia_Utility_UIStoryboardSegue_DoTransferSubviewKey = @"Eunomia_Utility_UIStoryboardSegue_DoTransferSubview";
NSString *const Eunomia_Utility_UIStoryboardSegue_TransferSubviewKey = @"Eunomia_Utility_UIStoryboardSegue_TransferSubview";
NSString *const Eunomia_Utility_UIStoryboardSegue_TransferSubviewLeftKey = @"Eunomia_Utility_UIStoryboardSegue_TransferSubviewLeft";
NSString *const Eunomia_Utility_UIStoryboardSegue_TransferSubviewTopKey = @"Eunomia_Utility_UIStoryboardSegue_TransferSubviewTop";
NSString *const Eunomia_Utility_UIStoryboardSegue_TransferSubviewWidthKey = @"Eunomia_Utility_UIStoryboardSegue_TransferSubviewWidth";
NSString *const Eunomia_Utility_UIStoryboardSegue_TransferSubviewHeightKey = @"Eunomia_Utility_UIStoryboardSegue_TransferSubviewHeight";

@interface UIStoryboardSegue (Eunomia_Utility_Private)

@property (readwrite) BOOL doTransferSubview;
@property (weak, readwrite, getter=getTransferSubview) UIView *transferSubview;
@property (strong, readwrite, getter=getTransferSubviewLeft) NSLayoutConstraint *transferSubviewLeft;
@property (strong, readwrite, getter=getTransferSubviewTop) NSLayoutConstraint *transferSubviewTop;
@property (strong, readwrite, getter=getTransferSubviewWidth) NSLayoutConstraint *transferSubviewWidth;
@property (strong, readwrite, getter=getTransferSubviewHeight) NSLayoutConstraint *transferSubviewHeight;

@end

@implementation UIStoryboardSegue (Eunomia_Utility)

+ (UIViewController *)safelyCastToViewController:(id)object
{
    UIViewController *result;
    if ( [object isKindOfClass:[UIViewController class] ] )
    {
        result = object;
    }
    return result;
}

- (UIViewController *)sourceViewControllerTyped
{
    return [UIStoryboardSegue safelyCastToViewController:self.sourceViewController];
}

- (UIViewController *)destinationViewControllerTyped
{
    return [UIStoryboardSegue safelyCastToViewController:self.destinationViewController];
}

- (void)performIfViewsAreAvailableOrReplace:(void(^)(UIViewController *sourceViewController, UIViewController *destinationViewController, UIView *sourceView, UIView *destinationView) )performIfViewsAreAvailable
{
    UIViewController *sourceViewController = self.sourceViewControllerTyped;
    UIViewController *destinationViewController = self.destinationViewControllerTyped;
    
    UIView *sourceView = sourceViewController.view;
    UIView *destinationView = destinationViewController.view;
    
    if (sourceView && destinationView)
    {
        if (performIfViewsAreAvailable)
        {
            performIfViewsAreAvailable(sourceViewController, destinationViewController, sourceView, destinationView);
        }
    } else
    {
        [sourceViewController replaceWithViewController:destinationViewController];
    }
}

- (void)performIfViewsWithParentAreAvailableOrReplace:(void(^)(UIViewController *sourceViewController, UIViewController *destinationViewController, UIViewController *parentViewController, UIView *sourceView, UIView *destinationView, UIView *parentView) )performIfViewsAreAvailable
{
    [self performIfViewsAreAvailableOrReplace:^(UIViewController *sourceViewController, UIViewController *destinationViewController, UIView *sourceView, UIView *destinationView) {
        
        UIViewController *parentViewController = sourceViewController.parentViewController;
        UIView *parentView = parentViewController.view;

        if (parentView)
        {
            if (performIfViewsAreAvailable)
            {
                performIfViewsAreAvailable(sourceViewController, destinationViewController, parentViewController, sourceView, destinationView, parentView);
            }
        } else
        {
            [sourceViewController replaceWithViewController:destinationViewController];
        }
    }];
}

- (void)notifySegueFinishedAnimating:(id)object
{
    if ( [object conformsToProtocol:@protocol(AnimatedSegueViewController) ] )
    {
        id<AnimatedSegueViewController> animatedSegueViewController = object;
        if ( [animatedSegueViewController respondsToSelector:@selector(segueFinishedAnimating:) ] )
        {
            [animatedSegueViewController segueFinishedAnimating:self];
        }
    }
}

#pragma mark ReplaceSegueViewController

- (void)doTransferSubviewPrep
{
    self.doTransferSubview = NO;
    
    BOOL sourceShouldTransfer = NO;
    id<ReplaceSegueSourceViewController> transferSource;
    if ( [self.sourceViewController conformsToProtocol:@protocol(ReplaceSegueSourceViewController) ] )
    {
        transferSource = (id<ReplaceSegueSourceViewController>)self.sourceViewController;
        
        sourceShouldTransfer = YES;
        if ( [transferSource respondsToSelector:@selector(replaceSegueSourceShouldTransferSubview:) ] )
        {
            sourceShouldTransfer = [transferSource replaceSegueSourceShouldTransferSubview:self];
        }
    }
    
    BOOL destinationShouldTransfer = NO;
    id<ReplaceSegueDestinationViewController> transferDestination;
    if ( [self.destinationViewController conformsToProtocol:@protocol(ReplaceSegueDestinationViewController) ] )
    {
        transferDestination = (id<ReplaceSegueDestinationViewController>)self.destinationViewController;

        destinationShouldTransfer = YES;
        if ( [transferDestination respondsToSelector:@selector(replaceSegueDestinationShouldTransferSubview:) ] )
        {
            destinationShouldTransfer = [transferDestination replaceSegueDestinationShouldTransferSubview:self];
        }
    }
    
    UIView *destinationView = self.destinationViewControllerTyped.view;
    
    if (sourceShouldTransfer && destinationShouldTransfer && destinationView)
    {
        if ( [transferSource respondsToSelector:@selector(replaceSegueSourceTransferSubview:) ] )
        {
            self.transferSubview = [transferSource replaceSegueSourceTransferSubview:self];
            
            if (self.transferSubview &&
                [transferDestination respondsToSelector:@selector(replaceSegueDestinationTransferSubviewDestinationRect:) ] &&
                [transferDestination respondsToSelector:@selector(replaceSegueDestinationTransferSubviewDestinationRectRelativeView:) ] )
            {
                [destinationView layoutSubviews];
                
                //                CGPoint relativeOrigin = [destinationView convertPoint:self.transferSubview.frame.origin fromView:self.transferSubview.superview];
                CGRect relativeStartFrame = //CGRectMake(relativeOrigin.x, relativeOrigin.y, self.transferSubview.frame.size.width, self.transferSubview.frame.size.height);
                [destinationView convertRect:self.transferSubview.frame fromView:self.transferSubview.superview];
                [self.transferSubview removeFromSuperview];
                
                [destinationView addSubview:self.transferSubview];
                
                self.transferSubviewLeft = [NSLayoutConstraint constraintWithItem:self.transferSubview
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:destinationView
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1.0 constant:relativeStartFrame.origin.x];
                [destinationView addConstraint:self.transferSubviewLeft];
                
                self.transferSubviewTop = [NSLayoutConstraint constraintWithItem:self.transferSubview
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:destinationView
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0 constant:relativeStartFrame.origin.y];
                [destinationView addConstraint:self.transferSubviewTop];
                
                self.transferSubviewWidth = [NSLayoutConstraint constraintWithItem:self.transferSubview
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0 constant:relativeStartFrame.size.width];
                [destinationView addConstraint:self.transferSubviewWidth];
                
                self.transferSubviewHeight = [NSLayoutConstraint constraintWithItem:self.transferSubview
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0 constant:relativeStartFrame.size.height];
                [destinationView addConstraint:self.transferSubviewHeight];
                
                [destinationView layoutIfNeeded];
                
                self.doTransferSubview = YES;
            }
        }
    }
}

- (void)doTransferSubviewDestinationFrame
{
    if (self.doTransferSubview)
    {
/*        id<ReplaceSegueSourceViewController> replaceLeftSource;
        if ( [self.sourceViewController conformsToProtocol:@protocol(ReplaceSegueSourceViewController) ] )
        {
            replaceLeftSource = (id<ReplaceSegueSourceViewController>)self.sourceViewController;
        }*/
        
        id<ReplaceSegueDestinationViewController> replaceLeftDestination;
        if ( [self.destinationViewController conformsToProtocol:@protocol(ReplaceSegueDestinationViewController) ] )
        {
            replaceLeftDestination = (id<ReplaceSegueDestinationViewController>)self.destinationViewController;
        }
        
        UIView *destinationView = self.destinationViewControllerTyped.view;
        CGRect transferSubviewDestinationRect = [replaceLeftDestination replaceSegueDestinationTransferSubviewDestinationRect:self];
        UIView *transferSubviewDestinationRectRelativeView = [replaceLeftDestination replaceSegueDestinationTransferSubviewDestinationRectRelativeView:self];
        
        CGRect transferDestinationRect = [destinationView convertRect:transferSubviewDestinationRect fromView:transferSubviewDestinationRectRelativeView];
        
        self.transferSubviewLeft.constant = transferDestinationRect.origin.x;
        self.transferSubviewTop.constant = transferDestinationRect.origin.y;
        self.transferSubviewWidth.constant = transferDestinationRect.size.width;
        self.transferSubviewHeight.constant = transferDestinationRect.size.height;
        
        [destinationView layoutIfNeeded];
    }
}

- (void)doTransferSubviewCompleteAnimation
{
    if (self.doTransferSubview)
    {
        [self.transferSubview removeFromSuperview];
        self.transferSubview = nil;
    }
}

- (void)setDoTransferSubview:(BOOL)doTransferSubview
{
    [self setProtocolRetainProperty:@selector(doTransferSubview)
                              value:[NSNumber numberWithBool:doTransferSubview] ];
}

- (BOOL)doTransferSubview
{
    BOOL result = NO;
    id object = [self getProtocolProperty:@selector(doTransferSubview)];
    if ( [object isKindOfClass:[NSNumber class] ] )
    {
        NSNumber *number = object;
        result = [number boolValue];
    }
    return result;
}

DefineProtocolProperty(UIView, TransferSubview);
DefineProtocolProperty(NSLayoutConstraint, TransferSubviewLeft);
DefineProtocolProperty(NSLayoutConstraint, TransferSubviewTop);
DefineProtocolProperty(NSLayoutConstraint, TransferSubviewWidth);
DefineProtocolProperty(NSLayoutConstraint, TransferSubviewHeight);

@end
