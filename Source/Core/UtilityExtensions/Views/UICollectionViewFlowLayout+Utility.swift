//
//  UICollectionViewFlowLayout+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    // return the number of items in width and height dimensions to fit the specified width
    public func numberOfItemsToFit(width : CGFloat, itemCount : Int) -> CGSize {
        var result = CGSize(width: 0, height: 0)
        
        var usedWidth = width
        while usedWidth > 0
        {
            if result.width > 0
            {
                usedWidth -= self.minimumInteritemSpacing
                if width >= self.itemSize.width
                {
                    result.width += 1
                    usedWidth -= self.itemSize.width
                } else
                {
                    break
                }
            } else
            {
                result.width += 1
                usedWidth -= self.itemSize.width
            }
        }
        
        result.height = CGFloat(itemCount / Int(result.width) )
        if itemCount % Int(result.width) > 0
        {
            result.height += 1
        }
        
        return result
    }
    
    public func heightForItemsToFit(width : CGFloat, itemCount : Int) -> CGFloat {
        
        var result : CGFloat
        
        if itemCount > 0
        {
            let numberOfItems = self.numberOfItemsToFit(width, itemCount: itemCount)
            
            result = CGFloat(numberOfItems.height) * self.itemSize.height
            if numberOfItems.height > 1
            {
                result += self.minimumLineSpacing * CGFloat(numberOfItems.height - 1)
            }
        } else
        {
            result = 0
        }
        
        return result
    }
}