//
//  AVURLAsset+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 6/20/17.
//  Copyright © 2017 Adorkable. All rights reserved.
//

import AVFoundation
#if os(iOS)
import UIKit
#endif

extension AVURLAsset {
    #if os(iOS)
    public func firstFrame() throws -> UIImage {
        let generate = AVAssetImageGenerator(asset: self)
        generate.appliesPreferredTrackTransform = true
        let time = CMTimeMake(1, 60)

        let imageReference = try generate.copyCGImage(at: time, actualTime: nil)
        return UIImage(cgImage: imageReference)
    }
    #endif
}
