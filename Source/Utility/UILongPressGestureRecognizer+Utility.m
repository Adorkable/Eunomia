//
//  UILongPressGestureRecognizer+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/28/14.
//
//

#import "UILongPressGestureRecognizer+Utility.h"

@implementation UILongPressGestureRecognizer (Eunomia_Utility)

+ (UILongPressGestureRecognizer *)recognizer
{
    return [self recognizerWithTarget:nil action:nil];
}

+ (UILongPressGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action
{
    return [ [UILongPressGestureRecognizer alloc] initWithTarget:target
                                                          action:action];
}

+ (UILongPressGestureRecognizer *)recognizerWithTarget:(id)target
                                                action:(SEL)action
                                  minimumPressDuration:(CFTimeInterval)minimumPressDuration
{
    UILongPressGestureRecognizer *recognizer = [self recognizerWithTarget:target action:action];
    recognizer.minimumPressDuration = minimumPressDuration;
    return recognizer;
}

+ (UILongPressGestureRecognizer *)recognizerWithTarget:(id)target
                                                action:(SEL)action
                                  minimumPressDuration:(CFTimeInterval)minimumPressDuration
                                     allowableMovement:(CGFloat)allowableMovement
{
    UILongPressGestureRecognizer *recognizer = [self recognizerWithTarget:target
                                                                   action:action
                                                     minimumPressDuration:minimumPressDuration];
    recognizer.allowableMovement = allowableMovement;
    return recognizer;
}

+ (UILongPressGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action
                                  minimumPressDuration:(CFTimeInterval)minimumPressDuration
                                     allowableMovement:(CGFloat)allowableMovement
                                  numberOfTapsRequired:(NSUInteger)numberOfTapsRequired
                               numberOfTouchesRequired:(NSUInteger)numberOfTouchesRequired
{
    UILongPressGestureRecognizer *recognizer = [self recognizerWithTarget:target
                                                                   action:action
                                                     minimumPressDuration:minimumPressDuration
                                                        allowableMovement:allowableMovement];

    recognizer.numberOfTapsRequired = numberOfTapsRequired;
    recognizer.numberOfTouchesRequired = numberOfTouchesRequired;
    
    return recognizer;
}

@end
