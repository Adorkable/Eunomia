//
//  UIColor+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 12/1/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class func randomComponent() -> CGFloat {
        return CGFloat(randomf())
    }
    
    public class func randomColor(alpha alpha : CGFloat = 1.0) -> UIColor {
        return UIColor(red: self.randomComponent(), green: self.randomComponent(), blue: self.randomComponent(), alpha: alpha)
    }
    
    public class func randomColorWithRandomAlpha() -> UIColor {
        return self.randomColor(alpha: self.randomComponent())
    }
    
    private class func increase(inout components : [CGFloat], byAmount amount : CGFloat) {
        
        var increased = [CGFloat]()
        
        for component in components {
            
            let increaseTo = min(component + amount, 1.0)
            increased.append(increaseTo)
        }
        
        components = increased
    }
    
    public class func randomColor(minimumIntensity minimumIntensity : CGFloat) -> UIColor {
        
        var components = [
            self.randomComponent(),
            self.randomComponent(),
            self.randomComponent()
        ]
        
        var biggestDifference : CGFloat = 0
        for component in components {
            if component < minimumIntensity {
                let difference = minimumIntensity - component
                
                if difference > biggestDifference {
                    biggestDifference = difference
                }
            }
        }
        
        if biggestDifference > 0 {
            self.increase(&components, byAmount: biggestDifference)
        }
        
        return self.colorWithRGBComponents(components)
    }
    
    private class func componentValueAtIndex(components : [CGFloat], index : Int) -> CGFloat? {
        guard index < components.count else {
            return nil
        }
        
        return components[index]
    }
    
    public class func colorWithRGBComponents(components : [CGFloat]) -> UIColor {
        let red = guarantee(self.componentValueAtIndex(components, index: 0), fallback: 0)
        let green = guarantee(self.componentValueAtIndex(components, index: 1), fallback: 0)
        let blue = guarantee(self.componentValueAtIndex(components, index: 2), fallback: 0)
        let alpha = guarantee(self.componentValueAtIndex(components, index: 3), fallback: 1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public class func byteComponentToCGFloat(value : u_char) -> CGFloat {
        return CGFloat(value) / 255.0
    }
}
