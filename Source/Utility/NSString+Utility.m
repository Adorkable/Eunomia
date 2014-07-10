//
//  NSString+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 4/17/14.
//
//

#import "NSString+Utility.h"

#import "Utility.h"

@implementation NSString (Eunomia_Utility)

+ (NSString *)randomStringOfLength:(NSUInteger)length withAllowedCharacters:(NSString *)allowedCharacters
{
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    
    NSRange range;
    range.length = 1;
    for (range.location = 0; range.location < length; range.location ++)
    {
        unichar randomCharacter = [allowedCharacters characterAtIndex:randomi() % allowedCharacters.length];
        [result appendFormat:@"%c", randomCharacter];
    }
    
    return result;
}

@end
