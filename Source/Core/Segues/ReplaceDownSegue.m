//
//  ReplaceDownSegue.m
//  Solace
//
//  Created by Ian on 7/5/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import "ReplaceDownSegue.h"

@implementation ReplaceDownSegue

- (void)perform
{
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    [sourceViewController.parentViewController addChildViewController:destinationViewController];
    
    destinationViewController.view.frame = CGRectMake(
                                                      0.0f,
                                                      0.0f - destinationViewController.view.frame.size.height,
                                                      destinationViewController.view.frame.size.width,
                                                      destinationViewController.view.frame.size.height
                                                      );
    
    [sourceViewController.parentViewController transitionFromViewController:sourceViewController
                                                           toViewController:destinationViewController
                                                                   duration:0.2f
                                                                    options:UIViewAnimationOptionCurveEaseInOut
                                                                 animations:^
     {
         sourceViewController.view.transform = CGAffineTransformTranslate(sourceViewController.view.transform, 0.0f, destinationViewController.view.frame.size.height);
         destinationViewController.view.transform = CGAffineTransformTranslate(destinationViewController.view.transform, 0.0f, destinationViewController.view.frame.size.height);
     } completion:^(BOOL finished)
     {
         [sourceViewController.view removeFromSuperview];
         [sourceViewController removeFromParentViewController];
     } ];
    
}

@end
