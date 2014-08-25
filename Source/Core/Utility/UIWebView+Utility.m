//
//  UIWebView+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/10/14.
//
//

#import "UIWebView+Utility.h"

@implementation UIWebView (Eunomia_Utility)

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
