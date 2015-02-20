//
//  NSObject+Utility.m
//  Eunomia
//
//  Created by Ian on 7/5/14.
//
//

#import "NSObject+Utility.h"

#import "NSNotification+Utility.h"

#import <objc/runtime.h>

@implementation NSObject (Eunomia_Utility)

- (NSString *)objectPerminentKey
{
    return [NSString stringWithFormat:@"%@ %p", [self class], self];
}

#pragma mark Casting

+ (BOOL)isClass:(NSObject *)object
{
    return [object isKindOfClass:[self class] ];
}

+ (instancetype)ofClass:(NSObject *)object
{
    id result = nil;
    if ( [self isClass:object] )
    {
        result = object;
    }
    return result;
}

#pragma mark Runtime Properties

- (void)setProtocolProperty:(const void *)key value:(id)value storageType:(uintptr_t)storageType
{
    objc_setAssociatedObject(self, key, value, storageType);
}

- (void)setProtocolRetainProperty:(const void *)key value:(id)value
{
    [self setProtocolProperty:key value:value storageType:OBJC_ASSOCIATION_RETAIN];
}

- (id)getProtocolProperty:(const void *)key
{
    return objc_getAssociatedObject(self, key);
}

- (void)setProtocolRetainProperty:(const void *)key boolValue:(BOOL)boolValue
{
    [self setProtocolRetainProperty:key value:[NSNumber numberWithBool:boolValue] ];
}

- (BOOL)getProtocolPropertyBool:(const void *)key defaultValue:(BOOL)defaultValue
{
    BOOL result = defaultValue;
    
    id propertyValue = [self getProtocolProperty:key];
    if ( [propertyValue isKindOfClass:[NSNumber class] ] )
    {
        NSNumber *numberValue = propertyValue;
        result = [numberValue boolValue];
    }
    return result;
}


#pragma mark Keyboard Notifications

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
