//
//  UIViewController+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

public extension UIViewController {
    
    func forceLoadView() {
        let _ = self.view
    }
    
    func childViewControllers(_ ofClass : AnyClass) -> [UIViewController]? {
        var result : [UIViewController]?
        
        let filteredChildren = self.children.filter( { $0.isKind(of: ofClass) } )
        if filteredChildren.count > 0
        {
            result = filteredChildren
        }
        
        return result
    }
    
    @IBAction func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}

public extension UIViewController {
    @IBAction func dismissSelfAnimated() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func dismissSelf() {
        self.dismiss(animated: false, completion: nil)
    }
}

#endif
