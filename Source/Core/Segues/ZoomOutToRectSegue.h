//
//  ZoomOutToRectSegue.h
//  Eunomia
//
//  Created by Ian Grossberg on 7/22/14.
//

#import <UIKit/UIKit.h>

@interface ZoomOutToRectSegue : UIStoryboardSegue

@end

@protocol ZoomOutToRectViewController <NSObject>

@required
- (CGRect)zoomOutToRectSegueDestinationRect:(ZoomOutToRectSegue *)segue;
- (UIView *)zoomOutToRectSegueDestinationRectRelativeView:(ZoomOutToRectSegue *)segue;

@optional
- (void)zoomOutToRectSegue:(ZoomOutToRectSegue *)segue zoomedOutViewSnapshot:(UIImage *)snapshot;

@end