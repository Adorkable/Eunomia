//
//  NSError+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

public let NSFunctionErrorKey = "FunctionError"
public let NSLineErrorKey = "LineError"

extension NSError {
    
    // TODO: support NSLocalizedString
    // TODO: support Recovery Attempter
    // TODO: relevant object
    public static func userInfo(description : String, underlyingError : NSError? = nil, failureReason : String? = nil, recoverySuggestion : String? = nil, recoveryOptions : [String]? = nil, fileName : String = __FILE__, functionName : String = __FUNCTION__, line : Int = __LINE__) -> [String : AnyObject] {
        
        var userInfo = [
            NSFilePathErrorKey : fileName,
            NSFunctionErrorKey : functionName,
            NSLineErrorKey : NSNumber(integer: line),
            
            NSLocalizedDescriptionKey : description
        ]
        
        if let underlyingError = underlyingError {
            userInfo[NSUnderlyingErrorKey] = underlyingError
        }
        
        if let failureReason = failureReason {
            userInfo[NSLocalizedFailureReasonErrorKey] = failureReason
        }
        
        if let recoverySuggestion = recoverySuggestion {
            userInfo[NSLocalizedRecoverySuggestionErrorKey] = recoverySuggestion
        }
        
        if let recoveryOptions = recoveryOptions {
            userInfo[NSLocalizedRecoveryOptionsErrorKey] = recoveryOptions
        }

        return userInfo
    }
    
    public convenience init(domain : String, code : Int, description : String, underlyingError : NSError? = nil, failureReason : String? = nil, recoverySuggestion : String? = nil, recoveryOptions : [String]? = nil, fileName : String = __FILE__, functionName : String = __FUNCTION__, line : Int = __LINE__) {
        
        let userInfo = NSError.userInfo(description, underlyingError: underlyingError, failureReason: failureReason, recoverySuggestion: recoverySuggestion, recoveryOptions: recoveryOptions, fileName: fileName, functionName: functionName, line: line)
        
        self.init(domain: domain, code: code, userInfo: userInfo)
    }
    
    public convenience init(description : String, underlyingError : NSError? = nil, failureReason : String? = nil, recoverySuggestion : String? = nil, recoveryOptions : [String]? = nil, fileName : String = __FILE__, functionName : String = __FUNCTION__, line : Int = __LINE__) {
        
        let userInfo = NSError.userInfo(description, underlyingError: underlyingError, failureReason: failureReason, recoverySuggestion: recoverySuggestion, recoveryOptions: recoveryOptions, fileName: fileName, functionName: functionName, line: line)
        
        self.init(domain: description, code: 0, userInfo: userInfo)
    }
}