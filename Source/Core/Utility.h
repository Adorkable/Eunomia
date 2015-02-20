//
//  Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/28/14.
//
//

#pragma once

#import "NSObject+Utility.h"

#import "UIApplication+Utility.h"

#import "NSBundle+Utility.h"

#import "JSContext+Utility.h"

#import "UIMenuController+Utility.h"

#import "NSString+Utility.h"
#import "NSMutableString+Utility.h"

#import "NSMutableArray+Utility.h"
#import "NSMutableDictionary+Utility.h"

#import "NSCharacterSet+Utility.h"

#import "UIColor+Utility.h"
#import "UIImage+Utility.h"

#import "UIBarItem+Utility.h"

#import "UIStoryboardSegue+Utility.h"

#import "NSNotification+Utility.h"

#import "NSFetchedResultsController+Utility.h"
#import "NSManagedObjectContext+Utility.h"
#import "NSManagedObject+Utility.h"

#import "UILongPressGestureRecognizer+Utility.h"
#import "UIPanGestureRecognizer+Utility.h"
#import "UITapGestureRecognizer+Utility.h"
#import "UIPinchGestureRecognizer+Utility.h"

#import "UIViewController+Utility.h"

#import "UIView+Utility.h"
#import "UIScrollView+Utility.h"
#import "UIWebView+Utility.h"
#import "UITextField+Utility.h"

#import "ALAssetsLibrary+Utility.h"
#import "UIImagePickerController+Utility.h"

#import "MFMailComposeViewController+Utility.h"

#import <UIKit/UIKit.h>

// returns a random CGFloat value between 0.0 and 1.0
extern CGFloat randomf();
extern u_int32_t randomi();

extern CGSize CGSizeMinusCGSize(CGSize left, CGSize right);
extern CGSize CGSizeMultiplied(CGSize size, CGFloat multiplier);

extern CGPoint CGPointMakeScaled(CGFloat width, CGFloat height, CGFloat scale);