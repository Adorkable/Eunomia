//
//  UIPinchGestureRecognizer+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 7/23/14.
//
//

#import "UIPinchGestureRecognizer+Utility.h"

@implementation UIPinchGestureRecognizer(Eunomia_Utility)

+ (UIPinchGestureRecognizer *)recognizer
{
    return [self recognizerWithTarget:nil action:nil];
}

+ (UIPinchGestureRecognizer *)recognizerWithTarget:(id)target
                                          action:(SEL)action
{
    return [ [UIPinchGestureRecognizer alloc] initWithTarget:target
                                                    action:action];
}

+ (UIPinchGestureRecognizer *)recognizerWithTarget:(id)target
                                            action:(SEL)action
                                             scale:(CGFloat)scale
{
    UIPinchGestureRecognizer *recognizer = [self recognizerWithTarget:target
                                                               action:action];
    recognizer.scale = scale;
    return recognizer;
}

@end
