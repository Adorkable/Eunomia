//
//  NSMutableDictionary+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 7/30/14.
//  
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Eunomia_Utility)

- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey;
- (void)setObjectSafe:(id)anObject forKeyObject:(NSObject *)keyObject;

- (id)objectForKeyObject:(NSObject *)aKey;

- (void)removeObjectForKeyObject:(NSObject *)aKey;

@end
