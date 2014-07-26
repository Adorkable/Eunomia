//
//  ZoomOutToRectSegue.m
//  Eunomia
//
//  Created by Ian Grossberg on 7/22/14.
//

#import "ZoomOutToRectSegue.h"

#import "Eunomia.h"

@implementation ZoomOutToRectSegue

- (void)perform
{
    [self performIfViewsWithParentAreAvailableOrReplace:^(UIViewController *sourceViewController, UIViewController *destinationViewController, UIViewController *parentViewController, UIView *sourceView, UIView *destinationView, UIView *parentView) {
        
        id<ZoomOutToRectViewController> zoomOutToRect;
        if ( [destinationViewController conformsToProtocol:@protocol(ZoomOutToRectViewController) ] )
        {
            zoomOutToRect = (id<ZoomOutToRectViewController>)destinationViewController;
        }
        
        UIImage *snapshot = [sourceView snapshotView];
        UIImageView *zoomView = [ [UIImageView alloc] initWithImage:snapshot];
        
        [parentViewController addChildViewController:destinationViewController];
        [parentView addSubview:destinationView];
        
        [parentView addSubview:zoomView];
        
        destinationView.frame = sourceView.frame;
        zoomView.frame = sourceView.frame;
        
        [sourceView removeFromSuperview];
        [sourceViewController removeFromParentViewController];

        [UIView animateWithDuration:0.2f animations:^{
            CGRect frame;
            if ( [zoomOutToRect respondsToSelector:@selector(zoomOutToRectSegueDestinationRect:) ] && [zoomOutToRect respondsToSelector:@selector(zoomOutToRectSegueDestinationRectRelativeView:) ] )
            {
                frame = [zoomView.superview convertRect:[zoomOutToRect zoomOutToRectSegueDestinationRect:self] fromView:[zoomOutToRect zoomOutToRectSegueDestinationRectRelativeView:self] ];
            }
            
            zoomView.frame = frame;
            
        } completion:^(BOOL finished) {
            if ( [zoomOutToRect respondsToSelector:@selector(zoomOutToRectSegue:zoomedOutViewSnapshot:) ] )
            {
                [zoomOutToRect zoomOutToRectSegue:self zoomedOutViewSnapshot:snapshot];
            }
            
            [zoomView removeFromSuperview];
        }];
        
    }];
}

@end
