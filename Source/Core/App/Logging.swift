//
//  Logging.swift
//  Eunomia
//
//  Created by Ian on 4/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

enum DDLogLevel {
    case error
    case warning
    case debug
    case info
    case verbose

    case other(String)
}
typealias DDLogFlag = DDLogLevel

class DDLog {
    struct DDLogMessage {
        let message: String
        let level: DDLogLevel
        let flag: DDLogFlag
        let context: Int
        let file: String
        let function: String?
        let line: UInt

        let threadName: String = Thread.current.name ?? ""
        let queueLabel: String = ""
    }

    static var consoleLogLevel: DDLogLevel = .info
    static let formatter = EunomiaCocoaLumberjackFormatter()
    
    public class func setupLogger(consoleLogLevel : DDLogLevel = DDLogLevel.info) throws {
        self.consoleLogLevel = consoleLogLevel
    }
    
    public class func log(message: String, level: DDLogLevel, flag: DDLogFlag, file: String, function: String, line: Int) {
        let ddLogMessage = DDLogMessage(message: message, level: level, flag: flag, context: 0, file: file, function: function, line: UInt(line))
        guard let fullLog = self.formatter.format(message: ddLogMessage) else {
            return
        }

        NSLog(fullLog)
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
    
    public class EunomiaCocoaLumberjackFormatter : NSObject {
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
                fileFunction += "\(String(describing: logMessage.function))"
            }
            if fileFunction.count > 0
            {
                result += " | {\(fileFunction)}"
            }
            
            return result;
        }
    }
}
