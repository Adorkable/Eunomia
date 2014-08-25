//
//  JSContext+Utility.h
//  Eunomia
//
//  Created by Ian Grossberg on 2/10/14.
//
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSContext (Eunomia_Utility)

- (void)setConsoleLogHandler:(NSString *(^)(NSString *parameter) )consoleLogHandler;
- (void)setPromptHandler:(NSString *(^)(NSString *promptTitle) )promptHandler;
- (void)setPromptResult:(NSString *)result;

@end
