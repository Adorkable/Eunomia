//
//  UIStoryboardSegue+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/14/14.
//
//

#import "UIStoryboardSegue+Utility.h"

#import "UIViewController+Utility.h"

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

@end
