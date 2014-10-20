//
//  NSObject+Utility.h
//  Eunomia
//
//  Created by Ian on 7/5/14.
//
//

#import <UIKit/UIKit.h>

@interface NSObject (Eunomia_Utility)

@property (readonly) NSString *objectPerminentKey; // TODO: is this necessary? NSObject.hash

- (void)setProtocolProperty:(NSString *)key value:(id)value storageType:(uintptr_t)storageType;
- (void)setProtocolRetainProperty:(NSString *)key value:(id)value;
- (id)getProtocolProperty:(NSString *)key;

- (void)registerForKeyboardNotifications;
- (void)unregisterForKeyboardNotifications;
- (void)keyboardWillShowWithBeginFrame:(CGRect)beginFrame
                              endFrame:(CGRect)endFrame
                              duration:(double)duration
                        animationCurve:(UIViewAnimationCurve)animationCurve;
- (void)keyboardWillHideWithBeginFrame:(CGRect)beginFrame
                              endFrame:(CGRect)endFrame
                              duration:(double)duration
                        animationCurve:(UIViewAnimationCurve)animationCurve;
- (void)alignWithKeyboardBeginFrame:(CGRect)beginFrame endFrame:(CGRect)endFrame duration:(double)duration animationCurve:(UIViewAnimationCurve)animationCurve;

@end
