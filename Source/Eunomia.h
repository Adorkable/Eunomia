//
//  Eunomia.h
//  Eunomia
//
//  Created by Ian Grossberg on 7/2/14.
//
//

#pragma once

#import "Config.h"

#define SetProtocolProperty(value, key) \
    objc_setAssociatedObject(self, CFBridgingRetain(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#define GetProtocolProperty(key) \
    objc_getAssociatedObject(self, CFBridgingRetain(key) )

// Cannot use with non-pointer types
#define DefineProtocolProperty(Type, Name, key) \
- (void)set##Name:(Type *)value \
{ \
    SetProtocolProperty(value, key); \
} \
\
- (Type *)get##Name \
{ \
    Type *result; \
    id object = GetProtocolProperty(key); \
    if ( [object isKindOfClass:[Type class] ] ) \
    { \
        result = object; \
    } \
    return result; \
}

#import "CoreData.h"
#import "Exceptions.h"
#import "Utility.h"
#import "ThirdParty.h"
#import "Segues.h"
#import "Views.h"
#import "View+Templating.h"
