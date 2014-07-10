//
//  UIViewController+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/14/14.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (Eunomia_Utility)

- (void)replaceWithViewController:(UIViewController *)viewController;
- (void)replaceWithViewController:(UIViewController *)viewController
                      inSuperview:(BOOL)inSuperview
           inParentViewController:(BOOL)inParentViewController
            andRootViewController:(BOOL)replaceRootViewController;

@end

@protocol ReceivesSender <NSObject>

@required
- (void)receiveSender:(id)sender;

@end