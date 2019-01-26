//
//  CGRect.swift
//  Eunomia
//
//  Created by Ian Grossberg on 1/25/19.
//  Copyright © 2018 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif

extension CGRect {
    public init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2,
                             y: center.y - size.height / 2)
        self.init(origin: origin, size: size)
    }
}
