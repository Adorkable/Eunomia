//
//  NSMutableString+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/20/14.
//
//

#import "NSMutableString+Utility.h"

@implementation NSMutableString (Eunomia_Utility)

- (void)appendStringSafe:(NSString *)aString
{
    if (aString.length > 0)
    {
        [self appendString:aString];
    }
}

- (void)appendString:(NSString *)aString withJoin:(NSString *)joinString
{
    if (aString.length > 0)
    {
        if (self.length > 0)
        {
            [self appendString:joinString];
        }
        [self appendString:aString];
    }
}

@end
