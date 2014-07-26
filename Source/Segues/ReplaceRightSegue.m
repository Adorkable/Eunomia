//
//  ReplaceRightSegue.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/11/14.
//
//

#import "ReplaceRightSegue.h"

#import "Eunomia.h"

@implementation ReplaceRightSegue

- (void)perform
{
    [self performIfViewsWithParentAreAvailableOrReplace:^(UIViewController *sourceViewController, UIViewController *destinationViewController, UIViewController *parentViewController, UIView *sourceView, UIView *destinationView, UIView *parentView) {
        
        [parentViewController addChildViewController:destinationViewController];
        
        destinationView.frame = CGRectMake(
                                           0.0f - destinationView.frame.size.width,
                                           0.0f,
                                           destinationView.frame.size.width,
                                           destinationView.frame.size.height
                                           );
        
        [parentViewController transitionFromViewController:sourceViewController
                                          toViewController:destinationViewController
                                                  duration:0.2f
                                                   options:UIViewAnimationOptionCurveEaseInOut
                                                animations:^
         {
             sourceView.transform = CGAffineTransformMakeTranslation(sourceView.frame.size.width, 0.f);
             destinationView.transform = CGAffineTransformMakeTranslation(destinationView.frame.size.width, 0.0f);
             
         } completion:^(BOOL finished) {
             [sourceView removeFromSuperview];
             [sourceViewController removeFromParentViewController];
         } ];
    }];
}

@end
