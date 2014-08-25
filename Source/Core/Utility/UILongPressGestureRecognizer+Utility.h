//
//  UILongPressGestureRecognizer+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/28/14.
//
//

#import <UIKit/UIKit.h>

@interface UILongPressGestureRecognizer (Eunomia_Utility)

+ (UILongPressGestureRecognizer *)recognizer;

+ (UILongPressGestureRecognizer *)recognizerWithTarget:(id)target
                                                action:(SEL)action;

+ (UILongPressGestureRecognizer *)recognizerWithTarget:(id)target
                                                action:(SEL)action
                                  minimumPressDuration:(CFTimeInterval)minimumPressDuration;

+ (UILongPressGestureRecognizer *)recognizerWithTarget:(id)target
                                                action:(SEL)action
                                  minimumPressDuration:(CFTimeInterval)minimumPressDuration
                                     allowableMovement:(CGFloat)allowableMovement;

+ (UILongPressGestureRecognizer *)recognizerWithTarget:(id)target
                                                action:(SEL)action
                                  minimumPressDuration:(CFTimeInterval)minimumPressDuration
                                     allowableMovement:(CGFloat)allowableMovement
                                  numberOfTapsRequired:(NSUInteger)numberOfTapsRequired
                               numberOfTouchesRequired:(NSUInteger)numberOfTouchesRequired;

@end
