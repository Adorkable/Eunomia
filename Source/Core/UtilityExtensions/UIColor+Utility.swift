//
//  UIColor+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 12/1/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

extension UIColor {
    
    public class func randomComponent() -> CGFloat {
        return CGFloat(CGFloat.random(in: 0.0...1.0))
    }
    
    public class func randomColor(alpha : CGFloat = 1.0) -> UIColor {
        return UIColor(red: self.randomComponent(), green: self.randomComponent(), blue: self.randomComponent(), alpha: alpha)
    }
    
    public class func randomColorWithRandomAlpha() -> UIColor {
        return self.randomColor(alpha: self.randomComponent())
    }
    
    fileprivate class func increase(_ components : inout [CGFloat], byAmount amount : CGFloat) {
        
        var increased = [CGFloat]()
        
        for component in components {
            
            let increaseTo = min(component + amount, 1.0)
            increased.append(increaseTo)
        }
        
        components = increased
    }
    
    public class func randomColor(minimumIntensity : CGFloat) -> UIColor {
        
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
    
    fileprivate class func componentValueAtIndex(_ components : [CGFloat], index : Int) -> CGFloat? {
        guard index < components.count else {
            return nil
        }
        
        return components[index]
    }
    
    public class func colorWithRGBComponents(_ components : [CGFloat]) -> UIColor {
        let red = guarantee(self.componentValueAtIndex(components, index: 0), fallback: 0)
        let green = guarantee(self.componentValueAtIndex(components, index: 1), fallback: 0)
        let blue = guarantee(self.componentValueAtIndex(components, index: 2), fallback: 0)
        let alpha = guarantee(self.componentValueAtIndex(components, index: 3), fallback: 1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public class func byteComponentToCGFloat(_ value : u_char) -> CGFloat {
        return CGFloat(value) / 255.0
    }
}

extension UIColor {
    public static func createFrom(named: String, fallback: UIColor) -> UIColor {
        guard #available(iOS 11.0, *) else {
            return fallback
        }
        guard let named = UIColor(named: named) else {
            return fallback
        }
        return named
    }
}

// Based on: https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values
extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int) {
        self.init(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0)
    }
    
    // Support alpha
    public convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    public convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        //        assert(red >= 0 && red <= 255, "Invalid red component")
        //        assert(green >= 0 && green <= 255, "Invalid green component")
        //        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
    
    public class InvalidFormatError: Error {
    }
    public convenience init(hex: String) throws {
        var string: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if string.hasPrefix("#") {
            string.remove(at: string.startIndex)
        }
        
        // Support with alpha
        if string.count != 6 {
            throw InvalidFormatError()
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: string).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
#endif
