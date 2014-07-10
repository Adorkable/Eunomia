//
//  NSMutableString+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/20/14.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableString (Eunomia_Utility)

- (void)appendStringSafe:(NSString *)aString;
- (void)appendString:(NSString *)aString withJoin:(NSString *)joinString;

@end
