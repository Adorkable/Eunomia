//
//  NSMutableDictionary+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 7/30/14.
//
//

#import "NSMutableDictionary+Utility.h"

#import "NSObject+Utility.h"

@implementation NSMutableDictionary (Eunomia_Utility)

- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject)
    {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)setObjectSafe:(id)anObject forKeyObject:(NSObject *)keyObject;
{
    if (anObject)
    {
        [self setObjectSafe:anObject forKey:keyObject.objectPerminentKey];
    }
}

- (id)objectForKeyObject:(NSObject *)aKey
{
    return [self objectForKey:aKey.objectPerminentKey];
}

- (void)removeObjectForKeyObject:(NSObject *)aKey
{
    [self removeObjectForKey:aKey.objectPerminentKey];
}

@end
