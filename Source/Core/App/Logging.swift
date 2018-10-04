//
//  Logging.swift
//  Eunomia
//
//  Created by Ian on 4/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import CocoaLumberjack
//    #if DEBUG
//        import NSLogger_CocoaLumberjack_connector
//    #endif

extension DDLog {
    
    public class func setupLogger(consoleLogLevel : DDLogLevel = DDLogLevel.info) throws {
//        #if DEBUG
//            // NSLogger connection
//            DDLog.addLogger(DDNSLoggerLogger.sharedInstance())
//        #else
//        #endif
        
        // Xcode Console connection
        guard let ddttyLogger = DDTTYLogger.sharedInstance else {
            throw SharedInstanceIsNilError(ofType: DDTTYLogger.self)
        }
        
        #if os(iOS)
        ddttyLogger.colorsEnabled = true
        ddttyLogger.setForegroundColor(UIColor(red: 0.973, green: 0.153, blue: 0.218, alpha: 1.0), backgroundColor: UIColor.white, for: DDLogFlag.error)
        ddttyLogger.setForegroundColor(UIColor(red: 0.9337, green:0.6441, blue:0.254, alpha:1.0), backgroundColor: UIColor.white, for: DDLogFlag.warning)
        ddttyLogger.setForegroundColor(UIColor(white: 0.212, alpha: 1.0), backgroundColor: UIColor.white, for: DDLogFlag.info)
        ddttyLogger.setForegroundColor(UIColor(red:0.391, green:0.520, blue:0.417, alpha: 1.0), backgroundColor: UIColor.white, for: DDLogFlag.debug)
        ddttyLogger.setForegroundColor(UIColor(white: 0.675, alpha: 1.0), backgroundColor: UIColor.white, for: DDLogFlag.verbose)
        #endif
        ddttyLogger.logFormatter = EunomiaCocoaLumberjackFormatter()
        
        // addLogger is inclusive from specified level and up, ie saying withLevel: Info means Info, Warning, Error
        DDLog.add(ddttyLogger, with: consoleLogLevel)
        
        // Crashlytics connection
        // TODO: check if Crashlytics Cocoapods is ok to use again
        //        var crashlyticsLogger = CrashlyticsLumberjack.sharedInstance()
        //        crashlyticsLogger.logFormatter = EunomiaCocoaLumberjackFormatter()
        //        DDLog.addLogger(crashlyticsLogger)
    }
    
    public class func log(message: String, level: DDLogLevel, flag: DDLogFlag, file: String, function: String, line: Int) {
        let ddLogMessage = DDLogMessage(message: message, level: level, flag: flag, context: 0, file: file, function: function, line: UInt(line), tag: nil, options: DDLogMessageOptions.dontCopyMessage, timestamp: nil)
        self.log(asynchronous: true, message: ddLogMessage)
    }
    
    public class func error(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: DDLogLevel.error, flag: DDLogFlag.error, file: fileName, function: functionName, line: line)
    }
    
    public class func warning(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: DDLogLevel.warning, flag: DDLogFlag.warning, file: fileName, function: functionName, line: line)
    }
    
    public class func info(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: DDLogLevel.info, flag: DDLogFlag.info, file: fileName, function: functionName, line: line)
    }
    
    public class func debug(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: DDLogLevel.debug, flag: DDLogFlag.debug, file: fileName, function: functionName, line: line)
    }
    
    public class func verbose(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: DDLogLevel.verbose, flag: DDLogFlag.verbose, file: fileName, function: functionName, line: line)
    }
    
    public class func logFlagAsString(logFlag : DDLogFlag) -> String {
        var result : String
        
        switch (logFlag)
        {
        case DDLogFlag.error:
            result = "E"
            break
        case DDLogFlag.warning:
            result = "W"
            break
        case DDLogFlag.info:
            result = "I"
            break
        case DDLogFlag.debug:
            result = "D"
            break
        case DDLogFlag.verbose:
            result = "V"
            break
        default:
            result = "?"
        }
        
        return result
    }
    
    public class EunomiaCocoaLumberjackFormatter : NSObject, DDLogFormatter {
        public /**
         * Formatters may optionally be added to any logger.
         * This allows for increased flexibility in the logging environment.
         * For example, log messages for log files may be formatted differently than log messages for the console.
         *
         * For more information about formatters, see the "Custom Formatters" page:
         * Documentation/CustomFormatters.md
         *
         * The formatter may also optionally filter the log message by returning nil,
         * in which case the logger will not log the message.
         **/
        func format(message logMessage: DDLogMessage) -> String? {

            var result = String()
            
            result += DDLog.logFlagAsString(logFlag: logMessage.flag)
            
            if logMessage.threadName.count > 0
            {
                result += " | thrd:\(logMessage.threadName)"
            }
            if logMessage.queueLabel.count > 0
            {
                result += " | gcd:\(logMessage.queueLabel)"
            }
            
            result += ": \(logMessage.message)"
            
            var fileFunction = String()
            if logMessage.file.count > 0
            {
                fileFunction += "\((logMessage.file as NSString).lastPathComponent):\(logMessage.line):"
            }
            if let function = logMessage.function,
                function.count > 0
            {
                fileFunction += "\(String(describing: function))"
            }
            if fileFunction.count > 0
            {
                result += " | {\(fileFunction)}"
            }
            
            return result;
        }
    }
}
