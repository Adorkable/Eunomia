//
//  VerboseDDLogFormatter.h
//  Solace
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

@class DDLogMessage;
@protocol DDLogFormatter;

@interface VerboseDDLogFormatter : NSObject< DDLogFormatter >

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage;

@end
