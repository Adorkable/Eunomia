//
//  ZoomInFromRectSegue.h
//  MobileTechPresentation
//
//  Created by Ian Grossberg on 7/23/14.
//
//

#import <UIKit/UIKit.h>

@interface ZoomInFromRectSegue : UIStoryboardSegue

@end

@protocol ZoomInFromRectViewController <NSObject>

@required
- (CGRect)zoomInFromRectSegueSourceRect:(ZoomInFromRectSegue *)segue;
- (UIView *)zoomInFromRectSegueSourceRectRelativeView:(ZoomInFromRectSegue *)segue;

@end