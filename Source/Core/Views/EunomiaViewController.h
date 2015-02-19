//
//  EunomiaViewController.h
//  Eunomia
//
//  Created by Ian on 1/31/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <SegueingInfo/SegueingInfo.h>

@interface EunomiaViewController : SegueingInfoViewController

@property (readwrite, nonatomic) IBInspectable NSString *analyticsViewName;

@end
