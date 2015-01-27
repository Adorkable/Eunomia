//
//  UITextField+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 4/25/14.
//
//

#import "UITextField+Utility.h"

#import "Eunomia.h"

@interface UITextFieldDelegate : NSObject<UITextFieldDelegate>

@property (copy) BOOL(^shouldReturn)(UITextField *textField);

@end

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

- (void)setShouldReturn:(BOOL (^)(UITextField *) )shouldReturn
{
    UITextFieldDelegate *delegate;
    if (shouldReturn)
    {
        delegate = [ [UITextFieldDelegate alloc] init];
        delegate.shouldReturn = shouldReturn;
        self.delegate = delegate;
    }
    [self setProtocolRetainProperty:@selector(shouldReturn) value:delegate];
}

- (BOOL (^)(UITextField *) )shouldReturn
{
    BOOL(^result)(UITextField *);
    
    id delegateObject = [self getProtocolProperty:@selector(shouldReturn) ];
    if ( [delegateObject isKindOfClass:[UITextFieldDelegate class] ] )
    {
        UITextFieldDelegate *delegate = delegateObject;
        result = delegate.shouldReturn;
    }
    
    return result;
}

@end

@implementation UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL result = YES;
    
    if (self.shouldReturn)
    {
        result = self.shouldReturn(textField);
    }
    
    return result;
}

@end