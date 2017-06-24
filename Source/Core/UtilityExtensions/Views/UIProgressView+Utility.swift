//
//  UIProgressView+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 6/23/17.
//  Copyright © 2017 Adorkable. All rights reserved.
//

import UIKit

extension UIProgressView {
    @available(iOS 10.0, *)
    public func scheduleUpdater(withTimeInterval timeInterval: TimeInterval, updater: @escaping (() -> Float), invalidatesWhen: @escaping ((_ progress: Float) -> Bool)) {

        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in

            self.progress = updater()

            if invalidatesWhen(self.progress) {
                timer.invalidate()
            }
        }
    }

    @available(iOS 10.0, *)
    public func autoprogress(from: Date, to: Date, finishEarlyCondition finishEarly: @escaping (() -> Bool)) {

        // TODO: throw if from > to
        // TODO: ability to specify time interval

        self.scheduleUpdater(withTimeInterval: 0.001, updater: { () -> Float in
            let result: Float

            let difference = to - from
            let nowDifference = Date() - from

            if difference == 0 {
                result = 0
            } else {
                result = Float(nowDifference / difference)
            }
            return result
        }) { (progress) -> Bool in

            if finishEarly() {
                return true
            }
            return progress >= 1
        }
    }
}
