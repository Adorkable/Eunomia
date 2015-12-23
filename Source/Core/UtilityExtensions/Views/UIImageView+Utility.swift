//
//  UIImageView+Utility.swift
//  Eunomia
//
//  Created by Ian on 5/6/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    // http://stackoverflow.com/a/6857098
    public func imageDisplayScale() -> CGSize {
        var result : CGSize
        
        if let image = self.image
        {
            let sx = Float(self.frame.size.width / image.size.width)
            let sy = Float(self.frame.size.height / image.size.height)
            var s : CGFloat = 1.0
            
            switch self.contentMode
            {
            case UIViewContentMode.ScaleAspectFit:
                s = CGFloat( fminf(sx, sy) )
                result = CGSize(width: s, height: s)
                break
                
            case UIViewContentMode.ScaleAspectFill:
                s = CGFloat( fmaxf(sx, sy) )
                result = CGSize(width: s, height: s)
                break
                
            case UIViewContentMode.ScaleToFill:
                result = CGSizeMake( CGFloat(sx), CGFloat(sy) )
                break
                
            default:
                result = CGSize(width: s, height: s)
            }
        } else
        {
            result = CGSizeZero
        }
        
        return result
    }
    
    public func imageDisplaySize() -> CGSize {
        var result : CGSize
        
        if self.image != nil
        {
            let imageScale = self.imageDisplayScale()
            
            result = CGSize(width: self.image!.size.width * imageScale.width, height: self.image!.size.height * imageScale.height)
        } else
        {
            result = CGSizeZero
        }
        
        return result
    }
    
    public func imageDisplayFrame() -> CGRect {
        var result : CGRect
        
        if self.image != nil
        {
            switch self.contentMode
            {
            case UIViewContentMode.ScaleAspectFit:
                let displaySize = self.imageDisplaySize()
                result = CGRect(x: (self.bounds.width - displaySize.width) / 2, y: (self.bounds.height - displaySize.height) / 2, width: displaySize.width, height: displaySize.height)
                break
                
            case UIViewContentMode.ScaleAspectFill:
                let displaySize = self.imageDisplaySize()
                result = CGRect(x: (self.bounds.width - displaySize.width) / 2, y: (self.bounds.height - displaySize.height) / 2, width: displaySize.width, height: displaySize.height)
                break
                
            case UIViewContentMode.ScaleToFill:
                result = self.bounds
                break

            case UIViewContentMode.Top:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
                
            case UIViewContentMode.TopLeft:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
                
            case UIViewContentMode.TopRight:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
                
            case UIViewContentMode.Bottom:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
                
            case UIViewContentMode.BottomLeft:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
                
            case UIViewContentMode.BottomRight:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
                
            case UIViewContentMode.Center:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
                
            case UIViewContentMode.Left:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
                
            case UIViewContentMode.Right:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
                
            case UIViewContentMode.Redraw:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRectZero
                break
            }

        } else
        {
            result = CGRectZero
        }
        
        return result
    }
}