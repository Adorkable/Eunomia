//
//  DispatchQueue+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 6/8/17.
//  Copyright © 2017 Adorkable. All rights reserved.
//

import Foundation

public extension DispatchQueue {

    /**
     Executes a block of code only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.

     - parameter block: Block to execute once
     */
    class func once(block: () -> Void) {
        self.once(token: String.randomString(64), block: block)
    }

    // From https://stackoverflow.com/a/38311178/96153
    private static var _onceTracker = [String]()

    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.

     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
}

public func dispatch_async_main(_ closure : @escaping () -> Void) {
    DispatchQueue.main.async(execute: closure)
}

public func dispatch_async_background(_ closure : @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async {
        closure()
    }
}

