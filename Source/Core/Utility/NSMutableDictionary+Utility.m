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

+ (NSDictionary *)dictionaryWithContentsOfJSONFile:(NSString *)path
{
    NSURL *url = [ [NSURL alloc] initFileURLWithPath:path];
    return [self dictionaryWithContentsOfJSONURL:url];
}

+ (NSDictionary *)dictionaryWithContentsOfJSONURL:(NSURL *)url
{
    NSDictionary *result;
    
    if (url)
    {
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        if (jsonData)
        {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil]; // TODO: all passing in error
            if ( [jsonObject isKindOfClass:[NSDictionary class] ] )
            {
                result = jsonObject;
            }
        }
    }
    
    return result;
}

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

- (id)keyForObject:(id)object
{
    __block id result;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj == object)
        {
            result = key;
            *stop = YES;
        }
    }];
    return result;
}

@end
