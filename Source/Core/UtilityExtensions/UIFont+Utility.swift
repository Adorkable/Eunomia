//
//  UIFont+Utility.swift
//  Eunomia
//
//  Created by Ian on 5/8/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

import UIKit

extension UIFont {
    class func supportedFonts() -> [String : [String]]? {
        var result : [String : [String]]?
    
        for familyName in UIFont.familyNames {
            let fonts = fontNames(forFamilyName: familyName)
            if fonts.count > 0 {
                
                if result == nil {
                    result = [String : [String]]()
                }
                
                if result != nil {
                    result![familyName] = fonts
                } else {
                    // TODO: log
                }
            }
        }
        
        return result
    }
    
    func fontWithTrait(_ trait : UIFontDescriptorSymbolicTraits) -> UIFont {
        let fontDescriptor = self.fontDescriptor.withSymbolicTraits(trait)
        return UIFont(descriptor: fontDescriptor!, size: self.pointSize)
    }
    
    func regularFont() -> UIFont? {
        return UIFont(name: self.fontName, size: self.pointSize)
    }
    
    func italicFont() -> UIFont {
        return self.fontWithTrait(.traitItalic)
    }
    
    func boldFont() -> UIFont {
        return self.fontWithTrait(.traitBold)
    }
    
    func expandedFont() -> UIFont {
        return self.fontWithTrait(.traitExpanded)
    }
    
    func condensedFont() -> UIFont {
        return self.fontWithTrait(.traitCondensed)
    }
    
    func monospaceFont() -> UIFont {
        return self.fontWithTrait(.traitMonoSpace)
    }
    
    func verticalFont() -> UIFont {
        return self.fontWithTrait(.traitVertical)
    }
    
    func uiOptimizedFont() -> UIFont {
        return self.fontWithTrait(.traitUIOptimized)
    }
    
    func tightLeadingFont() -> UIFont {
        return self.fontWithTrait(.traitTightLeading)
    }
    
    func looseLeadingFont() -> UIFont {
        return self.fontWithTrait(.traitLooseLeading)
    }
}
