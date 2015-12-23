//
//  Dispatch.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public func dispatch_async_main(closure : () -> Void) {
    dispatch_async(dispatch_get_main_queue(), closure)
}

public func dispatch_async_background(closure : () -> Void) {
    dispatch_async(dispatch_get_global_queue(0, 0), closure)
}