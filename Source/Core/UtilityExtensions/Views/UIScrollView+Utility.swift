//
//  UIScrollView+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 10/5/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

extension UIScrollView {
    
    fileprivate var filteredScrollLastContentOffsetKey : String {
        return "Eunomia_UIScrollView_filteredScrollLastContentOffsetKey"
    }
    fileprivate var filteredScrollLastContentOffset : CGFloat {
        get {
            return self.getAssociatedProperty(self.filteredScrollLastContentOffsetKey, fallback: 0)
        }
        set {
            self.setAssociatedRetainProperty(self.filteredScrollLastContentOffsetKey, value: newValue as AnyObject)
        }
    }
    
    public func applyFilteredScrollForScrollingBar(_ bar : UIView, barTopAlignment : NSLayoutConstraint, minimumDelta : CGFloat = 20) {
        
        let scrollDistance : CGFloat = self.contentOffset.y - self.filteredScrollLastContentOffset
        
        self.filteredScrollLastContentOffset = self.contentOffset.y
        
        // Minimum delta scroll before bar is effected, ie: only adjust past a minimum scroll speed. We allow even small amounts to pass if we're in the middle of hiding or showing the bar.
        guard abs(scrollDistance) > abs(minimumDelta) || (barTopAlignment.constant != 0 && barTopAlignment.constant != -bar.frame.height) else {
            return
        }
        
        // Only allow the topbar to move into and out of the area it's in and above
        guard barTopAlignment.constant - scrollDistance <= 0 else {
            
            barTopAlignment.constant = 0
            return
        }
        
        // Only move the topbar enough to hide it
        guard abs(barTopAlignment.constant - scrollDistance) <= bar.frame.height else {
            
            barTopAlignment.constant = -bar.frame.height
            return
        }
                
        barTopAlignment.constant -= scrollDistance / 2
        bar.superview?.setNeedsLayout()
    }
}
#endif
