//
//  UIPinchGestureRecognizer+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 7/23/14.
//
//

#import <UIKit/UIKit.h>

@interface UIPinchGestureRecognizer (Eunomia_Utility)

+ (UIPinchGestureRecognizer *)recognizer;
+ (UIPinchGestureRecognizer *)recognizerWithTarget:(id)target
                                            action:(SEL)action;
+ (UIPinchGestureRecognizer *)recognizerWithTarget:(id)target
                                            action:(SEL)action
                                             scale:(CGFloat)scale;

@end
