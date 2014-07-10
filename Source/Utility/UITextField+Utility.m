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

@end
