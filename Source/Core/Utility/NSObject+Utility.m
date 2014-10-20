//
//  NSObject+Utility.m
//  Eunomia
//
//  Created by Ian on 7/5/14.
//
//

#import "NSObject+Utility.h"

#import "NSNotification+Utility.h"

#import "Eunomia.h"

@implementation NSObject (Eunomia_Utility)

- (NSString *)objectPerminentKey
{
    return [NSString stringWithFormat:@"%@ %p", [self class], self];
}

- (void)registerForKeyboardNotifications
{
    [ [NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(keyboardWillShowWithNotification:)
                                                  name:UIKeyboardWillShowNotification
                                                object:nil];
    [ [NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(keyboardWillHideWithNotification:)
                                                  name:UIKeyboardWillHideNotification
                                                object:nil];
}

- (void)unregisterForKeyboardNotifications
{
    [ [NSNotificationCenter defaultCenter] removeObserver:self
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    [ [NSNotificationCenter defaultCenter] removeObserver:self
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
}

- (void)keyboardWillShowWithNotification:(NSNotification *)notification
{
    CGRect beginFrame = [ [notification objectForInfoKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [ [notification objectForInfoKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [ [notification objectForInfoKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animationCurve = [ [notification objectForInfoKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [self keyboardWillShowWithBeginFrame:beginFrame endFrame:endFrame duration:duration animationCurve:animationCurve];
}

- (void)keyboardWillShowWithBeginFrame:(CGRect)beginFrame
                              endFrame:(CGRect)endFrame
                              duration:(double)duration
                        animationCurve:(UIViewAnimationCurve)animationCurve
{
    [self alignWithKeyboardBeginFrame:beginFrame endFrame:endFrame duration:duration animationCurve:animationCurve];
}

- (void)keyboardWillHideWithNotification:(NSNotification *)notification
{
    CGRect beginFrame = [ [notification objectForInfoKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [ [notification objectForInfoKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [ [notification objectForInfoKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animationCurve = [ [notification objectForInfoKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [self keyboardWillHideWithBeginFrame:beginFrame endFrame:endFrame duration:duration animationCurve:animationCurve];
}

- (void)keyboardWillHideWithBeginFrame:(CGRect)beginFrame
                              endFrame:(CGRect)endFrame
                              duration:(double)duration
                        animationCurve:(UIViewAnimationCurve)animationCurve
{
    [self alignWithKeyboardBeginFrame:beginFrame endFrame:endFrame duration:duration animationCurve:animationCurve];
}

- (void)alignWithKeyboardBeginFrame:(CGRect)beginFrame endFrame:(CGRect)endFrame duration:(double)duration animationCurve:(UIViewAnimationCurve)animationCurve
{
}

@end
