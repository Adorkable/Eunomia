//
//  GCD+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

func dispatchOnMain(_ block : @escaping ()->()) {
    DispatchQueue.main.async(execute: block)
}
