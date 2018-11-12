//
//  UIImageView+Utility.swift
//  Eunomia
//
//  Created by Ian on 5/6/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

#if os(iOS)
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
            case UIView.ContentMode.scaleAspectFit:
                s = CGFloat( fminf(sx, sy) )
                result = CGSize(width: s, height: s)
                break
                
            case UIView.ContentMode.scaleAspectFill:
                s = CGFloat( fmaxf(sx, sy) )
                result = CGSize(width: s, height: s)
                break
                
            case UIView.ContentMode.scaleToFill:
                result = CGSize( width: CGFloat(sx), height: CGFloat(sy) )
                break
                
            default:
                result = CGSize(width: s, height: s)
            }
        } else
        {
            result = CGSize.zero
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
            result = CGSize.zero
        }
        
        return result
    }
    
    public func imageDisplayFrame() -> CGRect {
        var result : CGRect
        
        if self.image != nil
        {
            switch self.contentMode
            {
            case UIViewContentMode.scaleAspectFit:
                let displaySize = self.imageDisplaySize()
                result = CGRect(x: (self.bounds.width - displaySize.width) / 2, y: (self.bounds.height - displaySize.height) / 2, width: displaySize.width, height: displaySize.height)
                break
                
            case UIViewContentMode.scaleAspectFill:
                let displaySize = self.imageDisplaySize()
                result = CGRect(x: (self.bounds.width - displaySize.width) / 2, y: (self.bounds.height - displaySize.height) / 2, width: displaySize.width, height: displaySize.height)
                break
                
            case UIViewContentMode.scaleToFill:
                result = self.bounds
                break

            case UIViewContentMode.top:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
                
            case UIViewContentMode.topLeft:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
                
            case UIViewContentMode.topRight:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
                
            case UIViewContentMode.bottom:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
                
            case UIViewContentMode.bottomLeft:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
                
            case UIViewContentMode.bottomRight:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
                
            case UIViewContentMode.center:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
                
            case UIViewContentMode.left:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
                
            case UIViewContentMode.right:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
                
            case UIViewContentMode.redraw:
                NSLog("TODO: Eunomia UIImageView+Utility, imageDisplayFrame(): implement handling ContentMode")
                result = CGRect.zero
                break
            }

        } else
        {
            result = CGRect.zero
        }
        
        return result
    }
}
#endif
