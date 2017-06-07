//
//  UITabBar+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import UIKit

extension UITabBar {
    
    public func tabBarButtonViews() throws -> [UIView]? {
        
        let tabBarButtonClassName = "UITabBarButton"
        guard let tabBarButtonClass = NSClassFromString(tabBarButtonClassName) else {
            throw NSError(description: "Unable to retrieve instance of \(tabBarButtonClassName)")
        }
        
        var result : [UIView]?
        
        for view in self.subviews {
            
            if view.isKind(of: tabBarButtonClass) {
                
                if result == nil {
                    result = [UIView]()
                }
                
                guard result != nil else {
                    throw NSError(description: "Unable to allocate array for storage of Tab Bar Button Views")
                }
                
                result!.append(view)
            }
        }
        
        if result != nil {
            result?.sort { $0.0.frame.origin.x < $0.1.frame.origin.x }
        }
        
        return result
    }
    
}
