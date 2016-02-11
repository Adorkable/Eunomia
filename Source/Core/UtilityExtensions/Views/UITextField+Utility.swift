//
//  UITextField+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setErrorMode(enabled : Bool, nonErrorColor : UIColor = UIColor.clearColor(), nonErrorCornerRadius : CGFloat = 0, errorColor : UIColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.09), errorCornerRadius : CGFloat = 2) {

        if enabled == true {
            
            self.backgroundColor = errorColor
            self.cornerRadius = errorCornerRadius
        } else {
            
            self.backgroundColor = nonErrorColor
            self.cornerRadius = nonErrorCornerRadius
        }
    }
}