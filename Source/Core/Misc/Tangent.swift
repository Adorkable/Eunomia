//
//  Tangent.swift
//  Eunomia
//
//  Created by Ian Grossberg on 9/19/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import UIKit

public func tangent(from fromCenter: CGPoint, withRadius fromRadius: CGFloat, to toCenter: CGPoint, withRadius toRadius: CGFloat) -> CGPoint {
    // Based on http://www.ambrsoft.com/TrigoCalc/Circles2/Circles2Tangent_.htm
    let result: CGPoint
    if fromRadius == toRadius {
        // TODO: hack
        result = CGPoint(
            x: fromCenter.x + (toCenter.x - fromCenter.x) / 2 - fromRadius / 2,
            y: fromCenter.y + (toCenter.y - fromCenter.y) / 2 - fromRadius / 2
        )
    } else {
        result = CGPoint(
            x: (toCenter.x * fromRadius - fromCenter.x * toRadius) / (fromRadius - toRadius),
            y: (toCenter.y * fromRadius - fromCenter.y * toRadius) / (fromRadius - toRadius)
        )
    }
    
    return result
}
