//
//  LaunchView.h
//  Eunomia
//
//  Created by Ian Grossberg on 7/23/14.
//
//

#import <UIKit/UIKit.h>

@interface LaunchView : UIImageView

#if DEBUG
@property (readwrite) NSUInteger sharedInitCallCount;
#endif

@end
