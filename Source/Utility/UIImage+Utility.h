//
//  UIImage+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 5/29/14.
//

#import <UIKit/UIKit.h>

@interface UIImage (Eunomia_Utility)

- (UIColor *)colorAtLocation:(CGPoint)location;
+ (UIColor *)colorAtLocationInImage:(UIImage*)image atLocation:(CGPoint)location;

@end
