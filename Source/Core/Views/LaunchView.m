//
//  LaunchView.m
//  Eunomia
//
//  Created by Ian Grossberg on 7/23/14.
//
//

#import "LaunchView.h"

#import "NSLogWrapper.h"

@implementation LaunchView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self sharedInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self sharedInit];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self)
    {
        [self sharedInit];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self)
    {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
#if DEBUG
    self.sharedInitCallCount ++;
#endif
    [self setLaunchImage];
}

- (void)setLaunchImage
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
    
    if (image == nil)
    {
        NSLogWarning(@"Could not find expected Launch Image at %@", imagePath);
    }
    
    [self setImage:image];
}

@end
