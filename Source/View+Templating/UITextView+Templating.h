//
//  UITextView+Templating.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/10/14.
//
//

#import <UIKit/UIKit.h>

#import "UIView+Templating.h"

@interface UITextView (Eunomia_Templating)

- (instancetype)initWithFrame:(CGRect)frame
                  andTemplate:(UITextView *)template;
- (void)applyTemplate:(UIView *)baseTemplate;

@end
