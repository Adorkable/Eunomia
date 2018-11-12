//
//  Logging.swift
//  Eunomia
//
//  Created by Ian on 4/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

class Log {
    enum Level: CustomStringConvertible {
        case error
        case warning
        case debug
        case info
        case verbose

        var description: String {
            let result: String
            switch self {
            case .error:
                result = "E"

            case .warning:
                result = "W"

            case .info:
                result = "I"

            case .debug:
                result = "D"

            case .verbose:
                result = "V"
            }
            return result
        }
    }

    struct Message {
        let message: String
        let level: Level
        let context: Int
        let file: String
        let function: String
        let line: UInt

        let threadName: String? = Thread.current.name
    }

    static var consoleLevel: Level = .info
    static let formatter = LogFormatter()
    
    public class func setupLogger(consoleLogLevel: Level = .info) throws {
        self.consoleLevel = consoleLogLevel
    }
    
    public class func log(message: String, level: Level, file: String, function: String, line: Int) {
        let message = Message(message: message, level: level, context: 0, file: file, function: function, line: UInt(line))

        let stringMessage = self.formatter.format(message)
        NSLog(stringMessage)
    }
    
    public class func error(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: Level.error, file: fileName, function: functionName, line: line)
    }
    
    public class func warning(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: Level.warning, file: fileName, function: functionName, line: line)
    }
    
    public class func info(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: Level.info, file: fileName, function: functionName, line: line)
    }
    
    public class func debug(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: Level.debug, file: fileName, function: functionName, line: line)
    }
    
    public class func verbose(message : String, fileName : String = #file, functionName : String = #function, line : Int = #line) {
        self.log(message: message, level: Level.verbose, file: fileName, function: functionName, line: line)
    }
    
    public class LogFormatter : NSObject {
        func format(_ message: Message) -> String {

            var result = String()
            
            result += message.level.description
            
            if let threadName = message.threadName,
                threadName.count > 0
            {
                result += " | thrd:\(threadName)"
            }
            
            result += ": \(message.message)"
            
            var fileFunction = String()
            if message.file.count > 0
            {
                fileFunction += "\((message.file as NSString).lastPathComponent):\(message.line):"
            }
            if message.function.count > 0
            {
                fileFunction += "\(String(describing: message.function))"
            }
            if fileFunction.count > 0
            {
                result += " | {\(fileFunction)}"
            }
            
            return result;
        }
    }
}
