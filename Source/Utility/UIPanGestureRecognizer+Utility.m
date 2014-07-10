//
//  UIPanGestureRecognizer+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/28/14.
//
//

#import "UIPanGestureRecognizer+Utility.h"

@implementation UIPanGestureRecognizer (Eunomia_Utility)

+ (UIPanGestureRecognizer *)recognizer
{
    return [self recognizerWithTarget:nil action:nil];
}

+ (UIPanGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action
{
    return [ [UIPanGestureRecognizer alloc] initWithTarget:target
                                                    action:action];
}

+ (UIPanGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action
                          minimumNumberOfTouches:(NSUInteger)numberOfTouches
{
    UIPanGestureRecognizer *recognizer = [self recognizerWithTarget:target
                                                             action:action];
    recognizer.minimumNumberOfTouches = numberOfTouches;
    return recognizer;
}

@end
