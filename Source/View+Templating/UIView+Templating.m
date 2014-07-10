//
//  UIView+Templating.m
//  Eunomia
//
//  Created by Ian Grossberg on 11/21/13.
//
//

#import "UIView+Templating.h"

@implementation UIView (Eunomia_Templating)

- (void)applyTemplate:(UIView *)template
{
    if (template)
    {
        self.userInteractionEnabled = template.userInteractionEnabled;
        self.contentScaleFactor = template.contentScaleFactor;
        
        self.multipleTouchEnabled = template.multipleTouchEnabled;
        self.exclusiveTouch = template.exclusiveTouch;
        
        self.autoresizesSubviews = template.autoresizesSubviews;
        self.autoresizingMask = template.autoresizingMask;
        
        self.clipsToBounds = template.clipsToBounds;
        self.backgroundColor = template.backgroundColor;
        self.alpha = template.alpha;
        self.opaque = template.opaque;
        self.clearsContextBeforeDrawing = template.clearsContextBeforeDrawing;
        self.hidden = template.hidden;
        self.contentMode = template.contentMode;
        
        self.tintColor = template.tintColor;
        self.tintAdjustmentMode = template.tintAdjustmentMode;
    }
}

@end
