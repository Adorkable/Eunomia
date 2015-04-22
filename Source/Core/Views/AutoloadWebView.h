//
//  AutoloadWebView.h
//  Eunomia
//
//  Created by Ian on 2/4/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoloadWebView : UIWebView

@property (readwrite, nonatomic) IBInspectable NSString *urlString;
@property (readwrite, nonatomic) NSURL *url;

@end
