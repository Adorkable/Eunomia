//
//  EunomiaViewController.m
//  Eunomia
//
//  Created by Ian on 1/31/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "EunomiaViewController.h"

#if USE_ARANALYTICS
#import <ARAnalytics/ARAnalytics.h>
#endif

@implementation EunomiaViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
#if USE_ARANALYTICS
    if (self.analyticsViewName.length > 0)
    {
        [ARAnalytics pageView:self.analyticsViewName];
    }
#endif
}

@end
