//
//  UIImageView+Templating.m
//  Eunomia
//
//  Created by Ian Grossberg on 1/22/14.
//
//

#import "UIImageView+Templating.h"

#import "UIView+Templating.h"

@implementation UIImageView (Eunomia_Templating)

- (instancetype)initWithFrame:(CGRect)frame
                  andTemplate:(UIImageView *)template
{
    self = [self initWithFrame:frame];
    if (self)
    {
        [self applyTemplate:template];
    }
    return self;
}

// TODO: traverse array of properties to copy over rather than explicitly assign
- (void)applyTemplate:(UIView *)baseTemplate
{
    [super applyTemplate:baseTemplate];
    
    if ( [baseTemplate isKindOfClass:[UIImageView class] ] )
    {
        UIImageView *template = (UIImageView *)baseTemplate;
        
        self.image = template.image;
        self.highlightedImage = template.highlightedImage;
        
        self.userInteractionEnabled = template.userInteractionEnabled;
        
        self.highlighted = template.highlighted;
        
        self.animationImages = template.animationImages;
        self.highlightedAnimationImages = template.highlightedAnimationImages;
        self.animationDuration = template.animationDuration;
        self.animationRepeatCount = template.animationRepeatCount;
        
        self.tintColor = template.tintColor;
    }
}

@end
