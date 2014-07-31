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

+ (void)prepareDestinationViewControllerForSegue:(UIStoryboardSegue *)segue withSender:(id)sender;

@end

@protocol SegueingViewController <NSObject>

@required
- (void)destinationPrepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end

