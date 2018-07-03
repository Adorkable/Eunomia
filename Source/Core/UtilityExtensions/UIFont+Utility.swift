//
//  UIFont+Utility.swift
//  Eunomia
//
//  Created by Ian on 5/8/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

import UIKit

extension UIFont {
    public class func supportedFonts() -> [String : [String]]? {
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
    
    public func fontWithTrait(_ trait : UIFontDescriptorSymbolicTraits) -> UIFont {
        let fontDescriptor = self.fontDescriptor.withSymbolicTraits(trait)
        return UIFont(descriptor: fontDescriptor!, size: self.pointSize)
    }
    
    public func regularFont() -> UIFont? {
        return UIFont(name: self.fontName, size: self.pointSize)
    }
    
    public func italicFont() -> UIFont {
        return self.fontWithTrait(.traitItalic)
    }
    
    public func boldFont() -> UIFont {
        return self.fontWithTrait(.traitBold)
    }
    
    public func expandedFont() -> UIFont {
        return self.fontWithTrait(.traitExpanded)
    }
    
    public func condensedFont() -> UIFont {
        return self.fontWithTrait(.traitCondensed)
    }
    
    public func monospaceFont() -> UIFont {
        return self.fontWithTrait(.traitMonoSpace)
    }
    
    public func verticalFont() -> UIFont {
        return self.fontWithTrait(.traitVertical)
    }
    
    public func uiOptimizedFont() -> UIFont {
        return self.fontWithTrait(.traitUIOptimized)
    }
    
    public func tightLeadingFont() -> UIFont {
        return self.fontWithTrait(.traitTightLeading)
    }
    
    public func looseLeadingFont() -> UIFont {
        return self.fontWithTrait(.traitLooseLeading)
    }
}

extension UIFont {
    // https://stackoverflow.com/a/30450559
    public func width(withConstrainedHeight height: CGFloat, string: String) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = string.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: self], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    public func height(withConstrainedWidth width: CGFloat, string: String) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = string.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: self], context: nil)
        
        return ceil(boundingBox.height)
    }
}
