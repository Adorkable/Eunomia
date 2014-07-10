//
//  UIMenuController+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/27/14.
//
//

#import <UIKit/UIKit.h>

@interface UIMenuController (Eunomia_Utility)

- (void)showMenuItemTitles:(NSArray *)menuItemTitles
              atTargetRect:(CGRect)targetRect
                    inView:(UIView *)inView
                  animated:(BOOL)animated
                  selected:(void (^)(NSUInteger index) )selectedHandler
                 cancelled:(void (^)())cancelledHandler;

@end
