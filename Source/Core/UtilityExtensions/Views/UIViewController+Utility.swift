//
//  UIViewController+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func forceLoadView() {
        let _ = self.view
    }
    
    public func childViewControllers(ofClass : AnyClass) -> [UIViewController]? {
        var result : [UIViewController]?
        
        let filteredChildren = self.childViewControllers.filter( { $0.isKindOfClass(ofClass) } )
        if filteredChildren.count > 0
        {
            result = filteredChildren
        }
        
        return result
    }
    
    @IBAction public func popViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}