//
//  LaunchView.m
//  Eunomia
//
//  Created by Ian Grossberg on 7/23/14.
//
//

#import "LaunchView.h"

@implementation LaunchView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    NSString *imageLocation = [NSString stringWithFormat:@"%@", [ [NSBundle mainBundle] bundlePath] ];
    
    NSString *imageName;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        imageName = @"LaunchImage-700-Portrait@2x~ipad";
    } else
    {
        imageName = @"default.png";
    }
    
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", imageLocation, imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    [self setImage:image];
}

@end
