//
//  UIImageView+Templating.h
//  Eunomia
//
//  Created by Ian Grossberg on 1/22/14.
//
//

#import <UIKit/UIKit.h>

@interface UIImageView (Eunomia_Templating)

- (instancetype)initWithFrame:(CGRect)frame
                  andTemplate:(UIImageView *)template;

@end
