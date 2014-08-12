//
//  NSObject+Utility.h
//  Eunomia
//
//  Created by Ian on 7/5/14.
//
//

#import <UIKit/UIKit.h>

@interface NSObject (Eunomia_Utility)

@property (readonly) NSString *objectPerminentKey;

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

@end
