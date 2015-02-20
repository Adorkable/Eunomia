//
//  UIWebView+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/10/14.
//
//

#import <UIKit/UIKit.h>

@class JSContext;

@interface UIWebView (Eunomia_Utility)

@property (readwrite) IBInspectable BOOL useActivityIndicator;
@property (readonly) UIActivityIndicatorView *activityIndicator;
// TODO: swizzle delegate hooks?
- (void)startedActivity; // manual start and stop for the activity indicator so we don't take over the WebView's delegate
- (void)stoppedActivity;

- (JSContext *)jsContext;
- (void)loadFullCanvasHTML;

@end
