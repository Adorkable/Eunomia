//
//  UITableViewCell+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

extension UITableViewCell {
    
    public func contentViewContraint(attribute : NSLayoutAttribute) -> [NSLayoutConstraint]
    {
        return self.contentView.constraints.filter { (constraint) -> Bool in
            return constraint.firstAttribute == attribute && constraint.firstItem as? NSObject == self.contentView
        }
    }
}