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
    
        for familyName in UIFont.familyNames() {
            let fonts = fontNamesForFamilyName(familyName)
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
    
    func fontWithTrait(trait : UIFontDescriptorSymbolicTraits) -> UIFont {
        let fontDescriptor = self.fontDescriptor().fontDescriptorWithSymbolicTraits(trait)
        return UIFont(descriptor: fontDescriptor!, size: self.pointSize)
    }
    
    func regularFont() -> UIFont? {
        return UIFont(name: self.fontName, size: self.pointSize)
    }
    
    func italicFont() -> UIFont {
        return self.fontWithTrait(.TraitItalic)
    }
    
    func boldFont() -> UIFont {
        return self.fontWithTrait(.TraitBold)
    }
    
    func expandedFont() -> UIFont {
        return self.fontWithTrait(.TraitExpanded)
    }
    
    func condensedFont() -> UIFont {
        return self.fontWithTrait(.TraitCondensed)
    }
    
    func monospaceFont() -> UIFont {
        return self.fontWithTrait(.TraitMonoSpace)
    }
    
    func verticalFont() -> UIFont {
        return self.fontWithTrait(.TraitVertical)
    }
    
    func uiOptimizedFont() -> UIFont {
        return self.fontWithTrait(.TraitUIOptimized)
    }
    
    func tightLeadingFont() -> UIFont {
        return self.fontWithTrait(.TraitTightLeading)
    }
    
    func looseLeadingFont() -> UIFont {
        return self.fontWithTrait(.TraitLooseLeading)
    }
}
