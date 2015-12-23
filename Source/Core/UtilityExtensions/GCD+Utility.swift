//
//  GCD+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

func dispatchOnMain(block : dispatch_block_t) {
    dispatch_async(dispatch_get_main_queue(), block)
}
