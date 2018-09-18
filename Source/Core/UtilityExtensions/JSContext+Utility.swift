//
//  JSContext+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import JavaScriptCore

extension JSContext {

    public func setConsoleLogHandler(_ handler : @escaping @convention(block)(String) -> String) {
        self.setObject(unsafeBitCast(handler, to: AnyObject.self), forKeyedSubscript: "log" as NSCopying & NSObjectProtocol)
        
        // TODO: test if console already exists before creating each time
        self.evaluateScript("var console = new Object();")
        
        self.objectForKeyedSubscript("console").setObject(unsafeBitCast(handler, to: AnyObject.self), forKeyedSubscript: "log" as NSCopying & NSObjectProtocol)
    }
}
