//
//  UIBarItem+Utility.swift
//  Pods
//
//  Created by Ian Grossberg on 11/26/15.
//
//

import UIKit

extension UIBarItem {
    
    public var view : UIView? {
        return self.valueForKey("view") as? UIView
    }
}