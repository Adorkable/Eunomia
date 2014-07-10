//
//  NSObject+Utility.m
//  Eunomia
//
//  Created by Ian on 7/5/14.
//
//

#import "NSObject+Utility.h"

#import "NSNotification+Utility.h"

@implementation NSObject (Eunomia_Utility)



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
    CGRect beginFrame = [ [notification objectForInfoKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect endFrame = [ [notification objectForInfoKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    double duration = [ [notification objectForInfoKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    UIViewAnimationCurve animationCurve = [ [notification objectForInfoKey:@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
    
    [self keyboardWillShowWithBeginFrame:beginFrame endFrame:endFrame duration:duration animationCurve:animationCurve];
    
    /*     if (self.keyboardOpenedBy)
     {
     UIWindow *window = [AppDelegate sharedInstance].window;
     CGRect openedByFrame = [window convertRect:self.keyboardOpenedBy.frame
     fromView:self.keyboardOpenedBy.superview];
     
     [self shiftViewIfViewFrame:openedByFrame
     coveredByKeyboardFrame:self.keyboardOpenKeyboardFrame
     withDuration:animationDuration
     andCurve:animationCurve];
     }*/
}

- (void)keyboardWillShowWithBeginFrame:(CGRect)beginFrame
                              endFrame:(CGRect)endFrame
                              duration:(double)duration
                        animationCurve:(UIViewAnimationCurve)animationCurve
{
}

- (void)keyboardWillHideWithNotification:(NSNotification *)notification
{
    CGRect beginFrame = [ [notification objectForInfoKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect endFrame = [ [notification objectForInfoKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    double duration = [ [notification objectForInfoKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    UIViewAnimationCurve animationCurve = [ [notification objectForInfoKey:@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
    
    [self keyboardWillHideWithBeginFrame:beginFrame endFrame:endFrame duration:duration animationCurve:animationCurve];
    
    /*
     if (self.keyboardShiftedView)
     {
     UIViewAnimationCurve animationCurve = [ [notification objectForInfoKey:@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
     float animationDuration = [ [notification objectForInfoKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
     
     [UIView animateKeyframesWithDuration:animationDuration delay:0.0 options:0 animations:^{
     [UIView setAnimationCurve:animationCurve];
     [self.view setFrame:self.keyboardShiftedViewOriginalFrame];
     } completion:^(BOOL finished) {
     }];
     self.keyboardShiftedView = NO;
     }*/
}

- (void)keyboardWillHideWithBeginFrame:(CGRect)beginFrame
                              endFrame:(CGRect)endFrame
                              duration:(double)duration
                        animationCurve:(UIViewAnimationCurve)animationCurve
{
}

@end
