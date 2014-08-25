//
//  JSContext+Utility.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/10/14.
//
//

#import "JSContext+Utility.h"

@implementation JSContext (Eunomia_Utility)

- (void)setConsoleLogHandler:(NSString *(^)(NSString *parameter) )consoleLogHandler
{
    self[@"log"] = consoleLogHandler;
    [self evaluateScript:@"var console = new Object();"];
    self[@"console"][@"log"] = consoleLogHandler;
}

- (void)setPromptHandler:(NSString *(^)(NSString *) )promptHandler
{
//    [self evaluateScript:@"prompt = function(message){\n  promptResult = undefined;\n  promptCallback(message);\n  while(promptResult === undefined)\n  {\n  }\n  return promptResult;\n};"];
//    self[@"promptCallback"] = promptHandler;
    self[@"prompt"] = ^NSString *(NSString *message) {
        return @"Yahoo!"; 
    };
}

- (void)setPromptResult:(NSString *)promptResult
{
    self[@"promptResult"] = promptResult;
}

@end
