//
//  VerboseDDLogFormatter.h
//  Solace
//
//  Created by Ian on 5/24/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CocoaLumberjack/DDLog.h>

@interface VerboseDDLogFormatter : NSObject< DDLogFormatter >

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage;

@end
