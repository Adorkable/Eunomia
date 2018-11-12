//
//  UITableViewCell+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

extension UITableViewCell {
    
    public func contentViewContraint(_ attribute : NSLayoutAttribute) -> [NSLayoutConstraint]
    {
        return self.contentView.constraints.filter { (constraint) -> Bool in
            return constraint.firstAttribute == attribute && constraint.firstItem as? NSObject == self.contentView
        }
    }
}
#endif
