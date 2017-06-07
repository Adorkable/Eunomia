//
//  Errors.swift
//  Eunomia
//
//  Created by Ian Grossberg on 6/7/17.
//  Copyright © 2017 Adorkable. All rights reserved.
//

import UIKit

class SharedInstanceIsNilError: Error {
    let ofType: AnyClass
    init(ofType: AnyClass) {
        self.ofType = ofType
    }
}

class UnableToCreateNumberFromStringError: Error {
    let string: String
    init(string: String) {
        self.string = string
    }
}
