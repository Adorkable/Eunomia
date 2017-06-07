//
//  SuccessResult.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/12/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

public enum SuccessResult<T> {
    case success(T)
    case failure(NSError)
}
