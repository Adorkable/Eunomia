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

@interface UIViewController (Eunomia_Utility_WeAreAllTextSoAssignUs)

- (void)mapViews:(NSArray *)views forKey:(NSString *)key;
- (void)mapLabel:(UILabel *)label
       andButton:(UIButton *)button
    andTextField:(UITextField *)textField
     andTextView:(UITextView *)textView
          forKey:(NSString *)key;

- (void)setText:(NSString *)text toViews:(NSArray *)views;
- (void)setText:(NSString *)text toViewsWithKey:(NSString *)key;
- (void)setText:(NSString *)text
        toLabel:(UILabel *)label
      andButton:(UIButton *)button
   andTextField:(UITextField *)textField
    andTextView:(UITextView *)textView;

- (void)setHidden:(BOOL)hidden toViews:(NSArray *)views;
- (void)setHidden:(BOOL)hidden toViewsWithKey:(NSString *)key;
- (void)setHidden:(BOOL)hidden
          toLabel:(UILabel *)label
        andButton:(UIButton *)button
     andTextField:(UITextField *)textField
      andTextView:(UITextView *)textView;

@end