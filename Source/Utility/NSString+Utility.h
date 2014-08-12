//
//  NSString+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 4/17/14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Eunomia_Utility)

// TODO: random string without repeat
+ (NSString *)randomStringOfLength:(NSUInteger)length withAllowedCharacters:(NSString *)allowedCharacters;

- (BOOL)validEmail;

@end
