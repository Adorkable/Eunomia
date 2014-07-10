//
//  UITapGestureRecognizer+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/28/14.
//
//

#import <UIKit/UIKit.h>

@interface UITapGestureRecognizer (Eunomia_Utility)

+ (UITapGestureRecognizer *)recognizer; // TODO: test if this is alright
+ (UITapGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action;
+ (UITapGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action
                                    numberOfTaps:(NSUInteger)numberOfTaps
                                 numberOfTouches:(NSUInteger)numberOfTouches;

@end
