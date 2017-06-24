//
//  AVFoundation+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 6/22/17.
//  Copyright © 2017 Adorkable. All rights reserved.
//

import AVFoundation

extension AVPlayer {
    public var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
