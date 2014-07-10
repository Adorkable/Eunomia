//
//  UILabel+Templating.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/6/14.
//
//

#import "UILabel+Templating.h"

@implementation UILabel (Eunomia_Templating)

- (instancetype)initWithFrame:(CGRect)frame
                  andTemplate:(UILabel *)template
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
    
    if ( [baseTemplate isKindOfClass:[UILabel class] ] )
    {
        UILabel *template = (UILabel *)baseTemplate;
        
        self.text = template.text;
        self.font = template.font;
        self.textColor = template.textColor;
        self.shadowColor = template.shadowColor;
        self.shadowOffset = template.shadowOffset;
        self.textAlignment = template.textAlignment;
        self.lineBreakMode = template.lineBreakMode;
        self.attributedText = template.attributedText;
        
        self.highlightedTextColor = template.highlightedTextColor;
        self.highlighted = template.highlighted;
        
        self.userInteractionEnabled = template.userInteractionEnabled;
        self.enabled = template.enabled;
        
        self.numberOfLines = template.numberOfLines;
        self.adjustsFontSizeToFitWidth = template.adjustsFontSizeToFitWidth;
        self.baselineAdjustment = template.baselineAdjustment;
        self.minimumScaleFactor = template.minimumScaleFactor;
        
        self.preferredMaxLayoutWidth = template.preferredMaxLayoutWidth;
    }
}

@end
