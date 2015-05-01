//
//  UIMenuController+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/27/14.
//
//

#import "UIMenuController+Utility.h"

#import "Utility.h"

#import "NSLogWrapper.h"

#import <objc/runtime.h>

NSString *const UIMenuControllerResponderKey = @"UIMenuControllerResponder";

@interface UIMenuControllerResponder : UIView

@property (strong, readwrite) void (^selectedHandler)(NSUInteger index);
@property (strong, readwrite) void (^cancelledHandler)();

+ (NSString *)selectorTypeSelectorPrefix;
- (void)menuWillHide;

@end

@interface UIMenuController (UtilityPrivate)

@property (strong, readwrite) UIMenuControllerResponder *responder;

@end

@implementation UIMenuController (Eunomia_Utility)

- (void)showMenuItemTitles:(NSArray *)menuItemTitles
         atTargetRect:(CGRect)targetRect
               inView:(UIView *)inView
             animated:(BOOL)animated
                  selected:(void (^)(NSUInteger index) )selectedHandler
                 cancelled:(void (^)())cancelledHandler
{
    if (menuItemTitles.count > 0)
    {
        [self ensureResponder];
        self.responder.selectedHandler = selectedHandler;
        self.responder.cancelledHandler = cancelledHandler;
        
        [inView addSubview:self.responder];
        
        [ [NSNotificationCenter defaultCenter] addObserver:self.responder
                                                  selector:@selector(menuWillHide)
                                                      name:UIMenuControllerWillHideMenuNotification
                                                    object:nil];
        
        
        [self setMenuItems:nil]; // TODO: is this necessary each time?
        
        NSMutableArray *menuItems = [NSMutableArray array];
        for (id object in menuItemTitles)
        {
            if ( [object isKindOfClass:[NSString class] ] )
            {
                NSString *option = object;
                
                NSString *selectorName = [NSString stringWithFormat:@"%@%lu",
                                          [UIMenuControllerResponder selectorTypeSelectorPrefix],
                                          (unsigned long)[menuItemTitles indexOfObject:option]
                                          ];
                
                UIMenuItem *addItem = [ [UIMenuItem alloc] initWithTitle:option
                                                                  action:NSSelectorFromString(selectorName) ];
                [menuItems addObject:addItem];
            }
        }
        [self setMenuItems:menuItems];
        
        [self setTargetRect:targetRect inView:inView];
        
        [self.responder becomeFirstResponder];
        [self setMenuVisible:YES animated:animated];
    } else
    {
        NSLogWarning(@"Skipping attempt to show menu with no items!");
    }
}

- (void)ensureResponder
{
    if (!self.responder)
    {
        self.responder = [ [UIMenuControllerResponder alloc] init];
    }
}

- (void)setResponder:(UIMenuControllerResponder *)responder
{
	objc_setAssociatedObject(self, CFBridgingRetain(UIMenuControllerResponderKey), responder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIMenuControllerResponder *)responder
{
	return (UIMenuControllerResponder *)objc_getAssociatedObject(self, CFBridgingRetain(UIMenuControllerResponderKey) );
}


@end

@implementation UIMenuControllerResponder

- (id)init
{
    self = [super init];
    if (self)
    {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
    self.frame = CGRectZero;
    self.hidden = YES;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL result = NO;
    
    NSString *selectorName = NSStringFromSelector(action);
    if ( [UIMenuControllerResponder isSelectionTypeSelector:selectorName] )
    {
        result = YES;
    } else
    {
        result = [super canPerformAction:action withSender:sender];
    }
    
    return result;
}

+ (NSString *)selectorTypeSelectorPrefix
{
    return @"selectorType_";
}

+ (BOOL)isSelectionTypeSelector:(NSString *)selectorName
{
    NSRange match = [selectorName rangeOfString:[UIMenuControllerResponder selectorTypeSelectorPrefix] ];
    return match.location == 0 && match.length > 0;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    if ( [super methodSignatureForSelector:selector] )
    {
        return [super methodSignatureForSelector:selector];
    }
    return [super methodSignatureForSelector:@selector(optionSelected:) ];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *selectorName = NSStringFromSelector( [invocation selector] );
    
    if ( [UIMenuControllerResponder isSelectionTypeSelector:selectorName] )
    {
        NSString *indexString = [selectorName substringFromIndex:[ [UIMenuControllerResponder selectorTypeSelectorPrefix] length] ];
        
        [self optionSelected:(NSUInteger)[indexString integerValue]];
    } else
    {
        [super forwardInvocation:invocation];
    }
}

- (void)optionSelected:(NSUInteger)index
{
    [ [NSNotificationCenter defaultCenter] removeObserver:self
                                                     name:UIMenuControllerWillHideMenuNotification
                                                   object:nil];
    
    [self removeFromSuperview];
    
    if (self.selectedHandler)
    {
        self.selectedHandler(index);
    }
    [self clearHandlers];
}

- (void)menuWillHide
{
    [ [NSNotificationCenter defaultCenter] removeObserver:self
                                                     name:UIMenuControllerWillHideMenuNotification
                                                   object:nil];
    
    [self removeFromSuperview];
    
    if (self.cancelledHandler)
    {
        self.cancelledHandler();
    }
    [self clearHandlers];
}

- (void)clearHandlers
{
    self.selectedHandler = nil;
    self.cancelledHandler = nil;
}

@end
