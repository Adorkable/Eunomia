//
//  AutoloadWebView.m
//  Eunomia
//
//  Created by Ian on 2/4/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "AutoloadWebView.h"

#import "NSLogWrapper.h"

@implementation AutoloadWebView

- (void)setUrlString:(NSString *)urlString
{
    NSURL *newURL = [NSURL URLWithString:urlString];
    if (newURL)
    {
        self.url = newURL;
    } else
    {
        [NSLogWrapper error:@"Invalid url passed into setUrlString: %@", urlString];
    }
    
    if (self.superview != nil)
    {
        [self loadURL];
    }
}

- (NSString *)urlString
{
    return self.url.absoluteString;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    [self loadURL];
}

- (void)loadURL
{
    if (self.url)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
        [self loadRequest:request];
    }
}

@end
