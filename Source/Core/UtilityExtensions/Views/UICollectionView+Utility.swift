//
//  UICollectionView+Utility.swift
//  Allergy Abroad -> Eunomia
//
//  Created by Ian Grossberg on 7/6/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

public extension UICollectionView {
    func isLastCellVisible(inSection: Int) -> Bool {
        let lastIndexPath = IndexPath(row: self.numberOfItems(inSection: inSection) - 1, section: inSection)
        guard let cellAttributes = self.layoutAttributesForItem(at: lastIndexPath) else {
            // TODO:
            //            throw
            return false
        }
        let cellRect = self.convert(cellAttributes.frame, to: self.superview)

        var visibleRect = CGRect(
            x: self.bounds.origin.x,
            y: self.bounds.origin.y,
            width: self.bounds.size.width,
            height: self.bounds.size.height - self.contentInset.bottom
        )
        visibleRect = self.convert(visibleRect, to: self.superview)

        if visibleRect.intersects(cellRect) || visibleRect.contains(cellRect) {
            return true
        }

        return false
    }

    func isLastCellFullyVisible(inSection: Int) -> Bool {
        let lastIndexPath = IndexPath(row: self.numberOfItems(inSection: inSection) - 1, section: inSection)
        guard let cellAttributes = self.layoutAttributesForItem(at: lastIndexPath) else {
            // TODO:
            //            throw
            return false
        }
        let cellRect = self.convert(cellAttributes.frame, to: self.superview)

        var visibleRect = CGRect(
            x: self.bounds.origin.x,
            y: self.bounds.origin.y,
            width: self.bounds.size.width,
            height: self.bounds.size.height - self.contentInset.bottom
        )
        visibleRect = self.convert(visibleRect, to: self.superview)

        if visibleRect.contains(cellRect) {
            return true
        }

        return false
    }
}
#endif
