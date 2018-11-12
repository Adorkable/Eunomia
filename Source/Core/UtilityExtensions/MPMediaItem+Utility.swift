//
//  MPMediaItem+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 9/20/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import MediaPlayer

#if os(iOS)
extension MPMediaItem {
    public static func sortByPlaybackDuration(left: MPMediaItem, right: MPMediaItem) -> Bool {
        let comparison: ComparisonResult = self.sortByPlaybackDuration(left: left, right: right)
        return comparison == .orderedDescending
    }
    
    public static func sortByPlaybackDuration(left: MPMediaItem, right: MPMediaItem) -> ComparisonResult {
        if left.playbackDuration < right.playbackDuration {
            return .orderedDescending
        }
        if left.playbackDuration == right.playbackDuration {
            return .orderedSame
        }
        return .orderedAscending
    }
}

extension Array where Element == MPMediaItem {
    public func sortedByPlaybackDuration() -> [MPMediaItem] {
        return self.sorted(by: MPMediaItem.sortByPlaybackDuration)
    }
}
#endif
