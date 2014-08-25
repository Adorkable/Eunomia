//
//  UITextField+Templating.h
//  Eunomia
//
//  Created by Ian Grossberg on 11/21/13.
//
//

#import <UIKit/UIKit.h>

@interface UITextField (Eunomia_Templating)

- (instancetype)initWithFrame:(CGRect)frame
                  andTemplate:(UITextField *)template;

@end
