//
//  UITextField+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 4/25/14.
//
//

#import "UITextField+Utility.h"

@implementation UITextField (Eunomia_Utility)

// TODO: FIX ONLY WORKS AFTER TEXT IS SET
- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor
{
    if (self.placeholder)
    {
        NSAttributedString *attributedPlaceholder = [ [NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: placeholderTextColor} ];
        if (attributedPlaceholder)
        {
            self.attributedPlaceholder = attributedPlaceholder;
        }
    }
}

- (UIColor *)placeholderTextColor
{
    UIColor *result;
    
    NSRange searchRange;
    searchRange.location = 0;
    searchRange.length = self.attributedPlaceholder.length;
    
    [self.attributedPlaceholder enumerateAttribute:NSForegroundColorAttributeName inRange:searchRange options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        NSLog(@"%@", value);
    }];
    
    return result;
}

- (void)errorVibrate:(CGFloat)duration distance:(CGFloat)distance
{
    CGFloat keyframeDuration = duration / 4;
    CGRect originalFrame = self.frame;
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0f
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^
     {
         [UIView addKeyframeWithRelativeStartTime:keyframeDuration * 0
                                 relativeDuration:keyframeDuration
                                       animations:^
          {
              self.transform = CGAffineTransformTranslate(self.transform, -distance, 0);
          }];
         [UIView addKeyframeWithRelativeStartTime:keyframeDuration * 1
                                 relativeDuration:keyframeDuration * 2
                                       animations:^
          {
              self.transform = CGAffineTransformTranslate(self.transform, distance * 2, 0);
          }];
         [UIView addKeyframeWithRelativeStartTime:keyframeDuration * 3
                                 relativeDuration:keyframeDuration * 2
                                       animations:^
          {
              self.frame = originalFrame;
          }];
     } completion:^(BOOL finished)
     {
         
     }];
}

@end
