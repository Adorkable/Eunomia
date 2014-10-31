//
//  Eunomia.h
//  Eunomia
//
//  Created by Ian Grossberg on 7/2/14.
//
//

#pragma once

#import "Config.h"

#import "CoreData.h"
#import "Exceptions.h"
#import "Utility.h"

// Cannot use with non-pointer types
#define DefineProtocolProperty(Type, Name) \
- (void)set##Name:(Type *)value \
{ \
    [self setProtocolRetainProperty:@selector(get##Name) value:value]; \
} \
\
- (Type *)get##Name \
{ \
    Type *result; \
    id object = [self getProtocolProperty:@selector(get##Name)]; \
    if ( [object isKindOfClass:[Type class] ] ) \
    { \
        result = object; \
    } \
    return result; \
}

#import "ThirdParty.h"
#import "Segues.h"
#import "Views.h"
#import "View+Templating.h"
