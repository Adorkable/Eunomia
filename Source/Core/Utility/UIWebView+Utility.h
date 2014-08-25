//
//  UIWebView+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/10/14.
//
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface UIWebView (Eunomia_Utility)

- (JSContext *)jsContext;
- (void)loadFullCanvasHTML;

@end
