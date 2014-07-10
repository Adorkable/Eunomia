//
//  UITapGestureRecognizer+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/28/14.
//
//

#import "UITapGestureRecognizer+Utility.h"

@implementation UITapGestureRecognizer (Eunomia_Utility)

+ (UITapGestureRecognizer *)recognizer
{
    return [self recognizerWithTarget:nil action:nil];
}

+ (UITapGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action
{
    return [ [UITapGestureRecognizer alloc] initWithTarget:target
                                                    action:action];
}

+ (UITapGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action
                                    numberOfTaps:(NSUInteger)numberOfTaps
                                 numberOfTouches:(NSUInteger)numberOfTouches
{
    UITapGestureRecognizer *recognizer = [self recognizerWithTarget:target
                                                             action:action];
    recognizer.numberOfTapsRequired = numberOfTaps;
    recognizer.numberOfTouchesRequired = numberOfTouches;
    return recognizer;
}

@end
