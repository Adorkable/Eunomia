//
//  UIViewController+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

extension UIViewController {
    
    public func forceLoadView() {
        let _ = self.view
    }
    
    public func childViewControllers(_ ofClass : AnyClass) -> [UIViewController]? {
        var result : [UIViewController]?
        
        let filteredChildren = self.children.filter( { $0.isKind(of: ofClass) } )
        if filteredChildren.count > 0
        {
            result = filteredChildren
        }
        
        return result
    }
    
    @IBAction public func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
#endif
