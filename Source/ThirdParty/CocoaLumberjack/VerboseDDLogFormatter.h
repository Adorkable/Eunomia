//
//  VerboseDDLogFormatter.h
//  Solace
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <CocoaLumberjack/CocoaLumberjack.h>
@protocol DDLogFormatter;
@class DDLogMessage;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
@interface VerboseDDLogFormatter : NSObject< DDLogFormatter >

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage;

@end
#pragma clang diagnostic pop