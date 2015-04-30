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

+ (BOOL)isClass:(NSObject *)object;
+ (instancetype)ofClass:(NSObject *)object;

- (void)setProtocolProperty:(const void *)key value:(id)value storageType:(uintptr_t)storageType;
- (void)setProtocolRetainProperty:(const void *)key value:(id)value;
- (id)getProtocolProperty:(const void *)key;

- (void)setProtocolRetainProperty:(const void *)key boolValue:(BOOL)boolValue;
- (BOOL)getProtocolPropertyBool:(const void *)key defaultValue:(BOOL)defaultValue;

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

#define DefineProtocolProperty(Type, Name) \
    - (void)set##Name:(Type *)value \
    { \
        [self setProtocolRetainProperty:@selector(get##Name) value:value]; \
    } \
\
    - (Type *)get##Name \
    { \
        Type *result; \
        id object = [self getProtocolProperty:@selector(get##Name)]; \
        if ( [object isKindOfClass:[Type class] ] ) \
        { \
            result = object; \
        } \
        return result; \
    }