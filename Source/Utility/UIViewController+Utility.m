//
//  UIViewController+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/14/14.
//
//

#import "UIViewController+Utility.h"

@implementation UIViewController (Eunomia_Utility)

- (void)replaceInSuperviewWithViewController:(UIViewController *)viewController
{
    if (self.view.superview)
    {
        UIView *superview = self.view.superview;
        [self.view removeFromSuperview];
        [superview addSubview:viewController.view];
    }
}

- (void)replaceInParentViewControllerWithViewController:(UIViewController *)viewController
{
    if (self.parentViewController)
    {
        UIViewController *parentViewController = self.parentViewController;
        [self removeFromParentViewController];
        [parentViewController addChildViewController:viewController];
    }
}

- (void)replaceRootViewControllerWithViewController:(UIViewController *)viewController
{
    id< UIApplicationDelegate > appDelegate = [UIApplication sharedApplication].delegate;
    UIWindow *window = [appDelegate window];
    if (window.rootViewController == self)
    {
        window.rootViewController = viewController;
    }
}

- (void)replaceWithViewController:(UIViewController *)viewController
{
    [self replaceWithViewController:viewController
                        inSuperview:YES
             inParentViewController:YES
              andRootViewController:YES];
}

- (void)replaceWithViewController:(UIViewController *)viewController
                      inSuperview:(BOOL)inSuperview
           inParentViewController:(BOOL)inParentViewController
            andRootViewController:(BOOL)replaceRootViewController
{
    if (inSuperview)
    {
        [self replaceInSuperviewWithViewController:viewController];
    }
    if (inParentViewController)
    {
        [self replaceInParentViewControllerWithViewController:viewController];
    }
    if (replaceRootViewController)
    {
        [self replaceRootViewControllerWithViewController:viewController];
    }
}

+ (void)prepareDestinationViewControllerForSegue:(UIStoryboardSegue *)segue withSender:(id)sender
{
    if ( [segue.destinationViewController conformsToProtocol:@protocol(SegueingViewController) ] )
    {
        id<SegueingViewController> segueingViewController = segue.destinationViewController;
        if ( [segueingViewController respondsToSelector:@selector(destinationPrepareForSegue:sender:) ] )
        {
            [segueingViewController destinationPrepareForSegue:segue sender:sender];
        }
    }
}

@end
