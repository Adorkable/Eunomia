//
//  ZoomInFromRectSegue.m
//  MobileTechPresentation
//
//  Created by Ian Grossberg on 7/23/14.
//
//

#import "ZoomInFromRectSegue.h"

#import "Eunomia.h"

@implementation ZoomInFromRectSegue

- (void)perform
{
    [self performIfViewsWithParentAreAvailableOrReplace:^(UIViewController *sourceViewController, UIViewController *destinationViewController, UIViewController *parentViewController, UIView *sourceView, UIView *destinationView, UIView *parentView) {
        
        id<ZoomInFromRectViewController> zoomInFromRect;
        if ( [sourceViewController conformsToProtocol:@protocol(ZoomInFromRectViewController) ] )
        {
            zoomInFromRect = (id<ZoomInFromRectViewController>)sourceViewController;
        }
        
        [parentViewController addChildViewController:destinationViewController];
        [parentView addSubview:destinationView];
        destinationView.frame = sourceView.frame;
        
        UIImage *snapshot = [destinationView snapshotView];
        UIImageView *zoomView = [ [UIImageView alloc] initWithImage:snapshot];
        
        [destinationView removeFromSuperview];
        
        [parentView addSubview:zoomView];
        
        CGRect frame;
        if ( [zoomInFromRect respondsToSelector:@selector(zoomInFromRectSegueSourceRect:) ] && [zoomInFromRect respondsToSelector:@selector(zoomInFromRectSegueSourceRectRelativeView:) ] )
        {
            frame = [zoomView.superview convertRect:[zoomInFromRect zoomInFromRectSegueSourceRect:self] fromView:[zoomInFromRect zoomInFromRectSegueSourceRectRelativeView:self] ];
        }
        zoomView.frame = frame;
        
        [UIView animateWithDuration:0.2f animations:^{
            
            zoomView.frame = sourceView.frame;
            
        } completion:^(BOOL finished) {

            [sourceView removeFromSuperview];
            [sourceViewController removeFromParentViewController];
            
            [parentView addSubview:destinationView];

            [zoomView removeFromSuperview];
            
            [self notifySegueFinishedAnimating:sourceViewController];
            [self notifySegueFinishedAnimating:destinationViewController];

        }];
        
    }];
}

@end
