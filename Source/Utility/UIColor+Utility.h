//
//  UIColor+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/28/14.
//

#import <UIKit/UIKit.h>

@interface UIColor (Eunomia_Utility)

+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithMinimumIntensity:(CGFloat)minimumIntensity;

+ (CGFloat)byteComponentToFloat:(unsigned char)value;

@end

// from https://github.com/kevinrenskers/UIColor-HexString
// and https://github.com/Codecademy/UIColor-HexString
@interface UIColor (Eunomia_Utility_HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString;
- (NSString *) hexString;
- (NSString *) hexStringWithAlpha;

@end