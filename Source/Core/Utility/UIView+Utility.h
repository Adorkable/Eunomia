//
//  UIView+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/6/14.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Eunomia_Utility)

- (void)replaceWithView:(UIView *)replaceWith;

@property (readonly) CGRect frameZeroOrigin;
@property (readwrite) CGPoint center;

@property (readwrite) UIColor *borderColor;
@property (readwrite) CGFloat borderWidth;
@property (readwrite) CGFloat cornerRadius;

// returns NSNotFound if not a parent view of the given view
- (NSInteger)hasSubviewAtDepth:(UIView *)view;

- (void)enumerateSelfAndSubViews:(void (^)(UIView *view) )block;
- (void)enumerateSubViews:(void (^)(UIView *view) )block;

- (NSArray *)getAllSubViewsOfClass:(Class)ofClass;

- (void)enumerateSelfAndSuperViews:(void (^)(UIView *view, BOOL *stop) )block;
- (void)enumerateSuperViews:(void (^)(UIView *superView, BOOL *stop) )block;
- (UIView *)getClosestSuperViewOfClass:(Class)ofClass;
- (UIView *)getClosestSelfOrSuperViewOfClasses:(NSArray*)ofClasses;
- (UIView *)getClosestSuperViewOfClasses:(NSArray*)ofClasses;

- (UIView *)getClosestSuperViewOfProtocol:(Protocol *)protocol;
- (UIView *)getClosestSuperViewWhichRespondsTo:(SEL)selector;

- (BOOL)resignFirstResponderRecursively;

- (UIImage *)snapshotView;

@end
