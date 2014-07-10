//
//  UILabel+Templating.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/6/14.
//
//

#import <UIKit/UIKit.h>

#import "UIView+Templating.h"

@interface UILabel (Eunomia_Templating)

- (instancetype)initWithFrame:(CGRect)frame
                  andTemplate:(UILabel *)template;

@end
