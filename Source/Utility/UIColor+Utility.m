//
//  UIColor+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/28/14.
//

#import "UIColor+Utility.h"

#import "Utility.h"

@implementation UIColor (Eunomia_Utility)

+ (CGFloat)randomComponent
{
    return randomf();
}

+ (UIColor *)randomColor
{
    return [UIColor colorWithRed:[self randomComponent]
                           green:[self randomComponent]
                            blue:[self randomComponent]
                           alpha:1.0f];
}

+ (void)increaseCompontents:(NSMutableArray *)components byAmount:(CGFloat)amount
{
    for (NSUInteger fixIndex = 0; fixIndex < components.count; fixIndex ++)
    {
        id preincreaseObject = [components objectAtIndex:fixIndex];
        
        if ( [preincreaseObject isKindOfClass:[NSNumber class] ] )
        {
            NSNumber *preincrease = preincreaseObject;
            CGFloat increaseTo = [preincrease floatValue] + amount;
            if (increaseTo > 1.0f)
            {
                increaseTo = 1.0f;
            }
            NSNumber *postincrease = [NSNumber numberWithDouble:(double)increaseTo];
            [components replaceObjectAtIndex:[components indexOfObject:preincrease] withObject:postincrease];
        }
    }
}

+ (UIColor *)randomColorWithMinimumIntensity:(CGFloat)minimumIntensity
{
    NSMutableArray *components = [ @[
                                    @( [self randomComponent] ),
                                    @( [self randomComponent] ),
                                    @( [self randomComponent] )
                                    ] mutableCopy];

    CGFloat biggestDifference = 0;
    for (id object in components)
    {
        if ( [object isKindOfClass:[NSNumber class] ] )
        {
            NSNumber *component = object;
            if ( [component floatValue] < minimumIntensity)
            {
                CGFloat difference = minimumIntensity - [component floatValue];
                
                if (difference > biggestDifference)
                {
                    biggestDifference = difference;
                }
            }
        }
    }
    
    if (biggestDifference > 0)
    {
        [self increaseCompontents:components byAmount:biggestDifference];
    }

    UIColor *result;
    @try
    {
        NSNumber *red = [components objectAtIndex:0];
        NSNumber *green = [components objectAtIndex:1];
        NSNumber *blue = [components objectAtIndex:2];

        result = [UIColor colorWithRed:(CGFloat)[red doubleValue]
                                 green:(CGFloat)[green doubleValue]
                                  blue:(CGFloat)[blue doubleValue]
                                 alpha:1.0f];
    } @catch (NSException *exception)
    {
        result = [UIColor randomColor];
    }
    return result;
}

+ (CGFloat)byteComponentToFloat:(unsigned char)value
{
    return (value * 1.0f) / 255.0f;
}

@end
