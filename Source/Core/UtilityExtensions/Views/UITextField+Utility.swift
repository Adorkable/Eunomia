//
//  UITextField+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

extension UITextField {
    
    func setErrorMode(_ enabled : Bool, nonErrorColor : UIColor = UIColor.clear, nonErrorCornerRadius : CGFloat = 0, errorColor : UIColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.09), errorCornerRadius : CGFloat = 2) {

        if enabled == true {
            
            self.backgroundColor = errorColor
            self.cornerRadius = errorCornerRadius
        } else {
            
            self.backgroundColor = nonErrorColor
            self.cornerRadius = nonErrorCornerRadius
        }
    }
}

extension UITextView {
    public func verticallyCenterContents() {
        let surroundingSpace = self.bounds.size.height - self.contentSize.height

        let inset: CGFloat
        if surroundingSpace > 0 {
            inset = max(0, surroundingSpace / 2.0)
        } else {
            inset = 0
        }
        self.contentInset = UIEdgeInsets(top: inset, left: self.contentInset.left, bottom: inset, right: self.contentInset.right)
    }
}
#endif
