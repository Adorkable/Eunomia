//
//  Dispatch.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public func dispatch_async_main(_ closure : @escaping () -> Void) {
    DispatchQueue.main.async(execute: closure)
}

public func dispatch_async_background(_ closure : @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async {
        closure()
    }
}
