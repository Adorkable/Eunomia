//
//  UIViewController+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/14/14.
//
//

#import "UIViewController+Utility.h"

#import "NSMutableArray+Utility.h"
#import "NSObject+Utility.h"
#import "NSMutableDictionary+Utility.h"

@implementation UIViewController (Eunomia_Utility)

- (void)replaceInSuperviewWithViewController:(UIViewController *)viewController
{
    if (self.view.superview)
    {
        UIView *superview = self.view.superview;
        [self.view removeFromSuperview];
        [superview addSubview:viewController.view];
    }
}

- (void)replaceInParentViewControllerWithViewController:(UIViewController *)viewController
{
    if (self.parentViewController)
    {
        UIViewController *parentViewController = self.parentViewController;
        [self removeFromParentViewController];
        [parentViewController addChildViewController:viewController];
    }
}

- (void)replaceRootViewControllerWithViewController:(UIViewController *)viewController
{
    id< UIApplicationDelegate > appDelegate = [UIApplication sharedApplication].delegate;
    UIWindow *window = [appDelegate window];
    if (window.rootViewController == self)
    {
        window.rootViewController = viewController;
    }
}

- (void)replaceWithViewController:(UIViewController *)viewController
{
    [self replaceWithViewController:viewController
                        inSuperview:YES
             inParentViewController:YES
              andRootViewController:YES];
}

- (void)replaceWithViewController:(UIViewController *)viewController
                      inSuperview:(BOOL)inSuperview
           inParentViewController:(BOOL)inParentViewController
            andRootViewController:(BOOL)replaceRootViewController
{
    if (inSuperview)
    {
        [self replaceInSuperviewWithViewController:viewController];
    }
    if (inParentViewController)
    {
        [self replaceInParentViewControllerWithViewController:viewController];
    }
    if (replaceRootViewController)
    {
        [self replaceRootViewControllerWithViewController:viewController];
    }
}

@end

NSString *const WeAreAllTextSoAssignUsViewGroupsKey = @"WeAreAllTextSoAssignUsViewGroups";

@interface UIViewController (Eunomia_Utility_WeAreAllTextSoAssignUs_Protected)

@property (strong, readwrite) NSMutableDictionary *viewGroups;

@end

@implementation NSArray (Eunomia_Utility_WeAreAllTextSoAssignUs)

+ (NSArray *)arrayOfLabel:(UILabel *)label
                andButton:(UIButton *)button
             andTextField:(UITextField *)textField
              andTextView:(UITextView *)textView
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectSafe:label];
    [array addObjectSafe:button];
    [array addObjectSafe:textField];
    [array addObjectSafe:textView];
    return array;
}

@end

@implementation UIViewController (Eunomia_Utility_WeAreAllTextSoAssignUs)

- (void)mapViews:(NSArray *)views forKey:(NSString *)key
{
    [self.viewGroups setObjectSafe:views forKey:key];
}

- (void)mapLabel:(UILabel *)label
       andButton:(UIButton *)button
    andTextField:(UITextField *)textField
     andTextView:(UITextView *)textView
          forKey:(NSString *)key
{
    [self mapViews:[NSArray arrayOfLabel:label andButton:button andTextField:textField andTextView:textView]
            forKey:key];
}

- (void)callOnViews:(void (^)(NSArray *views) )callBlock forKey:(NSString *)key
{
    id viewsId = [self.viewGroups objectForKey:key];
    if (viewsId && [viewsId isKindOfClass:[NSArray class] ] )
    {
        NSArray *views = (NSArray *)viewsId;
        callBlock( views );
    }
}

- (void)setViewGroups:(NSMutableDictionary *)viewGroups
{
    [self setProtocolRetainProperty:@selector(viewGroups) value:viewGroups];
}

- (NSMutableDictionary *)viewGroups
{
    NSMutableDictionary *result;
    
    id viewGroupsObject = [self getProtocolProperty:@selector(viewGroups) ];
    if ( [viewGroupsObject isKindOfClass:[NSMutableDictionary class] ] )
    {
        result = viewGroupsObject;
    } else
    {
        // Lazy Create
        result = [NSMutableDictionary dictionary];
        self.viewGroups = result;
    }
    return result;
}


+ (void)setText:(NSString *)text toView:(UIView *)view
{
    if ( [view isKindOfClass:[UILabel class] ] )
    {
        UILabel *label = (UILabel *)view;
        label.text = text;
    } else if ( [view isKindOfClass:[UIButton class] ] )
    {
        UIButton *button = (UIButton *)view;
        button.titleLabel.text = text;
    } else if ( [view isKindOfClass:[UITextField class] ] )
    {
        UITextField *textField = (UITextField *)view;
        textField.text = text;
    } else if ( [view isKindOfClass:[UITextView class] ] )
    {
        UITextView *textView = (UITextView *)view;
        textView.text = text;
    }
}

- (void)setText:(NSString *)text toViews:(NSArray *)views
{
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj isKindOfClass:[UIView class] ] )
        {
            UIView *view = obj;
            [UIViewController setText:text toView:view];
        }
    } ];
}

- (void)setText:(NSString *)text toViewsWithKey:(NSString *)key
{
    [self callOnViews:^(NSArray *views) {
        [self setText:text toViews:views];
    } forKey:key];
}

- (void)setText:(NSString *)text
        toLabel:(UILabel *)label
      andButton:(UIButton *)button
   andTextField:(UITextField *)textField
    andTextView:(UITextView *)textView
{
    [self setText:text
          toViews:[NSArray arrayOfLabel:label andButton:button andTextField:textField andTextView:textView] ];
}

+ (void)setHidden:(BOOL)hidden toView:(UIView *)view
{
    [view setHidden:hidden];
}

- (void)setHidden:(BOOL)hidden toViews:(NSArray *)views
{
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj isKindOfClass:[UIView class] ] )
        {
            UIView *view = obj;
            [UIViewController setHidden:hidden toView:view];
        }
    } ];
}

- (void)setHidden:(BOOL)hidden toViewsWithKey:(NSString *)key
{
    [self callOnViews:^(NSArray *views) {
        [self setHidden:hidden toViews:views];
    } forKey:key];
}

- (void)setHidden:(BOOL)hidden
          toLabel:(UILabel *)label
        andButton:(UIButton *)button
     andTextField:(UITextField *)textField
      andTextView:(UITextView *)textView
{
    [self setHidden:hidden
            toViews:[NSArray arrayOfLabel:label andButton:button andTextField:textField andTextView:textView] ];
}

@end