//
//  VerboseDDLogFormatter.h
//  Solace
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

#ifndef DDLog
#import "CocoaLumberjack.h"
#endif

@class DDLogMessage;

@interface VerboseDDLogFormatter : NSObject< DDLogFormatter >

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage;

@end
