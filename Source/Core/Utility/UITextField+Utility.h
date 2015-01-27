//
//  UITextField+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 4/25/14.
//
//

#import <UIKit/UIKit.h>

@interface UITextField (Eunomia_Utility)

@property (readwrite) UIColor *placeholderTextColor;

- (void)errorVibrate:(CGFloat)duration distance:(CGFloat)distance;

@property (copy) BOOL(^shouldReturn)(UITextField *textField);

@end
