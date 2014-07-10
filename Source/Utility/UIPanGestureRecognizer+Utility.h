//
//  UIPanGestureRecognizer+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/28/14.
//
//

#import <UIKit/UIKit.h>

@interface UIPanGestureRecognizer (Eunomia_Utility)

// TODO: block callback support

+ (UIPanGestureRecognizer *)recognizer; // TODO: test if this is alright
+ (UIPanGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action;
+ (UIPanGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action
                          minimumNumberOfTouches:(NSUInteger)numberOfTouches;

@end
