//
//  ReplaceRightSegue.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/11/14.
//
//

#import "ReplaceRightSegue.h"

#import "UIStoryboardSegue+Utility.h"

@implementation ReplaceRightSegue

- (void)perform
{
    [self performIfViewsWithParentAreAvailableOrReplace:^(UIViewController *sourceViewController, UIViewController *destinationViewController, UIViewController *parentViewController, UIView *sourceView, UIView *destinationView, UIView *parentView) {
        
        [parentViewController addChildViewController:destinationViewController];
        [parentView addSubview:destinationView];

        destinationView.frame = CGRectMake(
                                           0.0f - destinationView.frame.size.width,
                                           0.0f,
                                           destinationView.frame.size.width,
                                           destinationView.frame.size.height
                                           );
        
        [self doTransferSubviewPrep];
        
        [UIView animateWithDuration:0.2f animations:^{
            sourceView.transform = CGAffineTransformTranslate(sourceView.transform, sourceView.frame.size.width, 0.f);
            destinationView.transform = CGAffineTransformTranslate(destinationView.transform, destinationView.frame.size.width, 0.0f);
            
            [self doTransferSubviewDestinationFrame];
        } completion:^(BOOL finished) {
            [self doTransferSubviewCompleteAnimation];
            
            [sourceView removeFromSuperview];
            [sourceViewController removeFromParentViewController];
            
            [self notifySegueFinishedAnimating:sourceViewController];
            [self notifySegueFinishedAnimating:destinationViewController];
        }];
    }];
}

@end
