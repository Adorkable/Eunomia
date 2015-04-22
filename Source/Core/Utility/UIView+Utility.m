//
//  UIView+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/6/14.
//
//

#import "UIView+Utility.h"

@implementation UIView (Eunomia_Utility)

- (void)replaceWithView:(UIView *)replaceWith
{
    // TODO: copy constraints
    replaceWith.frame = self.frame;
    replaceWith.autoresizingMask = self.autoresizingMask;
    
    if (self.superview)
    {
        [self.superview insertSubview:replaceWith belowSubview:self];
        [self removeFromSuperview];
    }
}

- (CGRect)frameZeroOrigin
{
    return CGRectMake(
                      0, 0,
                      self.frame.size.width, self.frame.size.height
                      );
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}
- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (NSInteger)hasSubviewAtDepth:(UIView *)view
{
    NSInteger depth = 0;
    UIView *testView = view;
    while (testView)
    {
        if (testView == self)
        {
            break;
        }
        testView = testView.superview;
        depth ++;
    }
    
    if (testView == nil)
    {
        depth = NSNotFound;
    }
    
    return depth;
}

- (void)enumerateSelfAndSubViews:(void (^)(UIView *view) )block
{
    if (block)
    {
        block(self);
    }
    [self enumerateSubViews:block];
}

- (void)enumerateSubViews:(void (^)(UIView *view) )block
{
    if (block)
    {
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ( [obj isKindOfClass:[UIView class] ] )
            {
                UIView *subView = obj;
                block(subView);
                [subView enumerateSubViews:block];
            }
        }];
    }
}

- (NSArray *)getAllSubViewsOfClass:(Class)ofClass
{
    __block NSMutableArray *result = [NSMutableArray array];
    
    [self enumerateSubViews:^(UIView *view) {
        if ( [view isKindOfClass:ofClass] )
        {
            [result addObject:view];
        }
    }];
    
    return result;
}


- (void)enumerateSelfAndSuperViews:(void (^)(UIView *view, BOOL *stop) )block
{
    if (block)
    {
        BOOL stop = NO;
        UIView *testView = self;
        while (testView)
        {
            block(testView, &stop);
            if (stop)
            {
                break;
            }
            testView = testView.superview;
        }
    }
}

- (void)enumerateSuperViews:(void (^)(UIView *superView, BOOL *stop) )block
{
    [self.superview enumerateSelfAndSuperViews:block];
}

- (UIView *)getClosestSuperViewOfClass:(Class)ofClass
{
    __block UIView *result;
    
    [self enumerateSuperViews:^(UIView *superView, BOOL *stop) {
        if ( [superView isKindOfClass:ofClass] )
        {
            result = superView;
            *stop = YES;
        }
    }];
    
    return result;
}

- (UIView *)getClosestSelfOrSuperViewOfClasses:(NSArray*)ofClasses
{
    __block UIView *result;
    
    [self enumerateSelfAndSuperViews:^(UIView *view, BOOL *stop) {
        [ofClasses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stopClasses) {
            if ( [view isKindOfClass:obj] )
            {
                result = view;
                *stopClasses = YES;
                *stop = YES;
            }
        }];
    }];
    
    return result;
}

- (UIView *)getClosestSuperViewOfClasses:(NSArray*)ofClasses
{
    return [self.superview getClosestSelfOrSuperViewOfClasses:ofClasses];
}

- (UIView *)getClosestSuperViewOfProtocol:(Protocol *)protocol
{
    __block UIView *result;
    
    [self enumerateSuperViews:^(UIView *superView, BOOL *stop) {
        if ( [superView conformsToProtocol:protocol] )
        {
            result = superView;
            *stop = YES;
        }
    }];
    
    return result;
}

- (UIView *)getClosestSuperViewWhichRespondsTo:(SEL)selector
{
    __block UIView *result;
    
    [self enumerateSuperViews:^(UIView *superView, BOOL *stop) {
        if ( [superView respondsToSelector:selector] )
        {
            result = superView;
            *stop = YES;
        }
    }];
    
    return result;
}

- (BOOL)resignFirstResponderRecursively
{
    __block BOOL result = NO;
    
    result = [self resignFirstResponder];
    if (!result)
    {
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ( [obj isKindOfClass:[UIView class] ] )
            {
                UIView *view = obj;
                result = [view resignFirstResponderRecursively];
            }
        }];
    }
    
    return result;
}

- (UIImage *)snapshotView
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.layer renderInContext:context];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
