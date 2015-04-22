//
//  UIWebView+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/10/14.
//
//

#import "UIWebView+Utility.h"

#import "NSObject+Utility.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface UIWebView (Eunomia_Utility_Private)

@property (readwrite) UIActivityIndicatorView *activityIndicator;
@property (readwrite) NSLayoutConstraint *activityIndicatorHorizontal;
@property (readwrite) NSLayoutConstraint *activityIndicatorVertical;

@end

@implementation UIWebView (Eunomia_Utility)

- (void)updateConstraints
{
    [super updateConstraints];
    
    [self ensureActivityIndicatorConstraints];
}

- (void)setUseActivityIndicator:(BOOL)useActivityIndicator
{
    [self setProtocolRetainProperty:@selector(useActivityIndicator) boolValue:useActivityIndicator];
    if (useActivityIndicator)
    {
        UIActivityIndicatorView *activityIndicator = [ [UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.color = [UIColor darkGrayColor];
        activityIndicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        
        [self addSubview:activityIndicator];
        self.activityIndicator = activityIndicator;
        
        [self setNeedsUpdateConstraints];
    } else
    {
        self.activityIndicator = nil;
    }
}

- (BOOL)useActivityIndicator
{
    return [self getProtocolPropertyBool:@selector(useActivityIndicator) defaultValue:NO];
}

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator
{
    [self setProtocolRetainProperty:@selector(activityIndicator) value:activityIndicator];
}

- (UIActivityIndicatorView *)activityIndicator
{
    return [self getProtocolProperty:@selector(activityIndicator) ];
}

- (void)ensureActivityIndicatorConstraints
{
    if (self.activityIndicator)
    {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        
        if (!self.activityIndicatorHorizontal)
        {
            NSLayoutConstraint *horizontal = [NSLayoutConstraint constraintWithItem:self
                                                                          attribute:NSLayoutAttributeCenterX
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.activityIndicator
                                                                          attribute:NSLayoutAttributeCenterX
                                                                         multiplier:1.0
                                                                           constant:0.0];
            [self addConstraint:horizontal];
            self.activityIndicatorHorizontal = horizontal;
        }
        
        if (!self.activityIndicatorVertical)
        {
            NSLayoutConstraint *vertical = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.activityIndicator
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:0.0];
            [self addConstraint:vertical];
            self.activityIndicatorVertical = vertical;
        }
    }
}

- (void)setActivityIndicatorHorizontal:(NSLayoutConstraint *)activityIndicatorHorizontal
{
    [self setProtocolRetainProperty:@selector(activityIndicatorHorizontal) value:activityIndicatorHorizontal];
}

- (NSLayoutConstraint *)activityIndicatorHorizontal
{
    return [self getProtocolProperty:@selector(activityIndicatorHorizontal) ];
}

- (void)setActivityIndicatorVertical:(NSLayoutConstraint *)activityIndicatorVertical
{
    [self setProtocolRetainProperty:@selector(activityIndicatorVertical) value:activityIndicatorVertical];
}

- (NSLayoutConstraint *)activityIndicatorVertical
{
    return [self getProtocolProperty:@selector(activityIndicatorVertical) ];
}

- (void)startedActivity
{
    [self.activityIndicator startAnimating];
}

- (void)stoppedActivity
{
    [self.activityIndicator stopAnimating];
}

- (JSContext *)jsContext
{
    return [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
}

- (void)loadFullCanvasHTML
{
    // TODO: error handling when canvas not supported
    NSString *htmlString = [NSString stringWithFormat:@"<!DOCTYPE html>\n<html>\n  <head>\n    <style>\n      body {\n        margin: 0;\n        text-align: center; \n      }\n    </style>\n  </head>\n  <body>\n    <canvas id=\'canvas\' width=\'%d\' height=\'%d\'>\nCanvas not supported\n    </canvas>\n  </body>\n</html>"
                            , (int)self.frame.size.width
                            , (int)self.frame.size.height
                            ];
    [self loadHTMLString:htmlString baseURL:nil];
}

@end
