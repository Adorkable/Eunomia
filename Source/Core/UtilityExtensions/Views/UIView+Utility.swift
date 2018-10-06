//
//  UIView+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif

import CocoaLumberjack

#if os(iOS)
typealias ViewType = UIView
#elseif os(macOS)
typealias ViewType = NSView
#endif

// MARK: - Contained within
extension ViewType {
    #if os(iOS)
    /**
     Replace our location in the superview with another view
     
     - parameter replaceWith: view to replace ourself with
     */
    public func replaceWithView(_ replaceWith : UIView)
    {
        // TODO: copy constraints
        replaceWith.frame = self.frame
        replaceWith.autoresizingMask = self.autoresizingMask
        
        if let superview = self.superview
        {
            superview.insertSubview(replaceWith, aboveSubview: self)
            self.removeFromSuperview()
        }
    }
    #endif
    
    /**
     Remove all subviews
     */
    public func removeAllSubviews() {
        while self.subviews.count > 0
        {
            self.subviews.last?.removeFromSuperview()
        }
    }
}

#if os(iOS)
// MARK: - Border
extension UIView {
    @IBInspectable public var borderColor : UIColor? {
        get {
            if let cgColor = self.layer.borderColor {
                return UIColor(cgColor: cgColor)
            } else {
                return nil
            }
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable public var borderWidth : CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable public var cornerRadius : CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var shadowOffset : CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable public var shadowColor : UIColor? {
        get {
            guard let cgColor = self.layer.shadowColor else {
                return nil
            }
            
            return UIColor(cgColor: cgColor)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
}

// MARK: nib and storyboard Instances
extension UIView {
    public class func view(_ nibName: String?, bundle: Bundle?) -> UIView {
        let viewController = UIViewController(nibName: nibName, bundle: bundle)
        return viewController.view
    }
    
    public class func view<T : UIView>(nibName: String?, bundle: Bundle?) -> T? {
        let viewController = UIViewController(nibName: nibName, bundle: bundle)
        return viewController.view as? T
    }
    
    public class func view(_ storyboard: UIStoryboard, identifier : String) -> UIView {
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController.view
    }
    
    public func resignFirstResponderRecursively() -> Bool {
        var result : Bool = self.resignFirstResponder()
        if !result
        {
            for subview in self.subviews
            {
                result = subview.resignFirstResponderRecursively()
                if result
                {
                    break;
                }
            }
        }
        return result
    }
}

// MARK: Subviews
extension UIView {
    public func hasSubviewAtDepth(_ view : UIView) -> Int?
    {
        var result : Int?
        
        var depth = 0
        var testView : UIView? = view
        while testView != nil
        {
            if testView == self
            {
                result = depth
                break
            }
            
            testView = testView?.superview
            depth += 1
        }
        
        return result
    }
    
    public typealias UIViewEnumerater = ((_ view : UIView, _ stop : inout Bool) -> Void)
    
    public func enumerateSelfAndSubviews(_ apply : UIViewEnumerater)
    {
        var stop : Bool = false
        apply(self, &stop)
        
        if stop == false
        {
            self.enumerateSubviews(apply)
        }
    }
    
    public func enumerateSubviews(_ apply : UIViewEnumerater)
    {
        var stop : Bool = false
        self.enumerateSubviews(apply, stop: &stop)
    }
    
    public func enumerateSubviews(_ apply : UIViewEnumerater, stop : inout Bool)
    {
        for subview in self.subviews
        {
            var stop : Bool = false
            apply(subview, &stop)
            if stop == true
            {
                break
            }
            subview.enumerateSubviews(apply, stop: &stop)
            if stop == true
            {
                break
            }
        }
    }
    
    public func allSubviews<T : UIView>(_ ofClass : T.Type) -> [T]?
    {
        var result : [T]?
        
        self.enumerateSubviews { (view, stop) -> Void in
            if view.isKind(of: ofClass)
            {
                if result == nil
                {
                    result = [T]()
                }
                result!.append(view as! T)
            }
        }
        
        return result
    }
}

// MARK: Superviews
extension UIView {
    public func enumerateSelfAndSuperviews(_ apply : UIViewEnumerater)
    {
        var testView : UIView? = self
        while testView != nil
        {
            var stop : Bool = false
            apply(testView!, &stop)
            if stop == true
            {
                break
            }
            testView = testView!.superview
        }
    }

    public func enumerateSuperviews(_ apply : UIViewEnumerater)
    {
        self.superview?.enumerateSelfAndSuperviews(apply)
    }
    
    public func closestSuperview<T : UIView>(_ ofClass : T.Type) -> T?
    {
        var result : T?
        
        self.enumerateSuperviews { (view, stop) -> Void in
            if view.isKind(of: ofClass)
            {
                result = view as? T
                stop = true
            }
        }
        
        return result
    }

    public func closestSelfOrSuperview<T : UIView>(_ ofClasses : [T.Type]) -> T?
    {
        var result : T?
        
        self.enumerateSelfAndSuperviews { (view, stop : inout Bool) -> Void in
            for ofClass in ofClasses
            {
                if view.isKind(of: ofClass)
                {
                    result = view as? T
                    stop = true
                    break
                }
            }
        }
        
        return result
    }
    
    public func closestSuperview<T : UIView>(_ ofClasses : [T.Type]) -> T?
    {
        return self.superview?.closestSelfOrSuperview(ofClasses)
    }
    
    public func closestSelfOrSuperview<T : Protocol>(_ ofProtocol : Protocol) -> T?
    {
        var result : T?
        
        self.enumerateSelfAndSuperviews { (view, stop : inout Bool) -> Void in
            if view.conforms(to: ofProtocol)
            {
                result = view as? T
                stop = true
            }
        }
        
        return result
    }

    public func closestSuperview<T : Protocol>(_ ofProtocol : Protocol) -> T?
    {
        return self.superview?.closestSelfOrSuperview(ofProtocol)
    }
    
    public func closestSuperviewWhichRespondsTo(_ selector : Selector) -> UIView?
    {
        var result : UIView?
        
        self.enumerateSuperviews { (view, stop) -> Void in
            if view.responds(to: selector)
            {
                result = view
                stop = true
            }
        }
        
        return result
    }
    
    public func mostSuperview() -> UIView? {
        var result : UIView?
        
        self.enumerateSuperviews { (view, stop) -> Void in
            result = view
        }
        
        return result
    }
}

// MARK: Sizing
extension UIView {
    public var sizeThatFitsCurrentWidth : CGSize {
        return self.sizeThatFits(CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
    }
    
    public var heightThatFitsCurrentWidth : CGFloat {
        return self.sizeThatFitsCurrentWidth.height
    }
    
    public func sizeToFitCurrentWidth() {
        self.frame.size = self.sizeThatFitsCurrentWidth
    }
    
    public func sizeToFitCurrentWidthWithHeightConstraint(_ constraint : NSLayoutConstraint) {
        self.sizeToFitCurrentWidth()
        constraint.constant = self.heightThatFitsCurrentWidth
    }
}

// MARK: Snapshot
extension UIView {
    public func eunomia_snapshotView() -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0);
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        self.layer.render(in: context)

        let result = UIGraphicsGetImageFromCurrentImageContext()
            
        UIGraphicsEndImageContext()
        
        return result
    }
}

// MARK: - Shape
extension UIView {
    public func setRoundShaped() {
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.clipsToBounds = true
    }
}

// MARK: - Simple Animations
extension UIView {
    
    /**
     Vibrate side to side in an agitated manner, useful for illustrating an error
     
     - parameter duration: duration of the vibration
     - parameter distance: maximum distance to travel in either direction from the view's actual location
     */
    // TODO: custom number of cycles
    public func errorVibrate(_ duration : TimeInterval, distance : CGFloat) {
        
        let keyframeDuration = duration / 4
        let originalFrame = self.frame
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: { () -> Void in
            
            UIView.addKeyframe(withRelativeStartTime: keyframeDuration * 0, relativeDuration: keyframeDuration, animations: { () -> Void in
                self.transform = self.transform.translatedBy(x: -distance, y: 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: keyframeDuration * 1, relativeDuration: keyframeDuration * 2, animations: { () -> Void in
                self.transform = self.transform.translatedBy(x: distance * 2, y: 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: keyframeDuration * 3, relativeDuration: keyframeDuration, animations: { () -> Void in
                self.frame = originalFrame
            })
        }, completion: nil)
    }
    
    /**
     Fade the view in
     
     - parameter useHidden:     use .hidden rather than .alpha, useful for UIStackViews. Defaults to false
     - parameter duration:      duration for animation. Defaults to 0.25
     - parameter force:         force override with the starting value, if false the animation picks up wherever the view already is re: hidden or alpha. Defaults to false.
     - parameter startingAlpha: alpha to force apply when not using .hidden. Defaults to 0.
     - parameter options:       animation options
     - parameter completion:    completion handler
     */
    public func fadeIn(_ useHidden : Bool = false, duration : TimeInterval = 0.25, force : Bool = false, startingAlpha : CGFloat = 0, options : UIViewAnimationOptions = [], completion : ( (Bool) -> Void)? = nil) {

        if force == true {
            if useHidden == true {
                self.isHidden = true
            } else {
                self.alpha = startingAlpha
            }
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { () -> Void in
            if useHidden == true {
                self.isHidden = false
            } else {
                self.alpha = 1
            }
            }, completion: completion)
    }
    
    /**
     Fade the view out
     
     - parameter useHidden:     use .hidden rather than .alpha, useful for UIStackViews. Defaults to false
     - parameter duration:      duration for animation. Defaults to 0.25
     - parameter force:         force override with the starting value, if false the animation picks up wherever the view already is re: hidden or alpha. Defaults to false.
     - parameter startingAlpha: alpha to force apply when not using .hidden. Defaults to 1.
     - parameter options:       animation options
     - parameter completion:    completion handler
     */
    public func fadeOut(_ useHidden : Bool = false, duration : TimeInterval = 0.25, force : Bool = false, startingAlpha : CGFloat = 1, options : UIViewAnimationOptions = [], completion : ( (Bool) -> Void)? = nil) {
        
        if force == true {
            if useHidden == true {
                self.isHidden = false
            } else {
                self.alpha = startingAlpha
            }
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { () -> Void in
            if useHidden == true {
                self.isHidden = true
            } else {
                self.alpha = 0
            }
            }, completion: completion)

    }
    
    /**
     Animate the view from a sliver down to full size
     
     - parameter endSize:    ending size after the animation
     - parameter duration:   duration of the animation
     - parameter options:    animation options
     - parameter completion: completion handler
     */
    public func growDown(_ endSize : CGSize? = nil, duration : TimeInterval = 0.25, options : UIViewAnimationOptions = [], completion : ( (Bool) -> Void)? = nil) {
        
        let endFrame : CGRect
        
        if let endSize = endSize {
            endFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: endSize.width, height: endSize.height)
        } else {
            endFrame = self.frame
        }
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: endFrame.width, height: 0)
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { () -> Void in

            self.frame = endFrame
            }, completion: completion)
    }
}

// MARK: - General Use Activity Indicator
extension UIView {
    
    /// Activity Indicator Associated Property Key
    fileprivate static var ActivityIndicatorKey : String { return "Eunomia_UIView_Extension_ActivityIndicator" }
    /// General Use Activity Indicator
    fileprivate var activityIndicator : UIActivityIndicatorView? {
        get {
            return self.getAssociatedProperty(UIView.ActivityIndicatorKey)
        }
        set {
            self.setAssociatedRetainProperty(UIView.ActivityIndicatorKey, value: newValue)
        }
    }
    
    /**
     Show or hide the view's General Use Activity Indictor
     
     - parameter visible:       show or hide the activity indicator
     - parameter centered:      whether to center the activity indicator automatically with Layout Contraints
     - parameter configureView: configure the view handler
     */
    public func showActivityIndicator(_ visible : Bool, centered : Bool = true, configureView : ((_ activityIndicator : UIActivityIndicatorView, _ parentView : UIView) -> Void)? = nil) {
        
        if visible == true {
            
            if self.activityIndicator == nil {
                let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
                
                self.addSubview(activityIndicator)
                if centered == true {
                    let horizontalCenter = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
                    let verticalCenter = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
                    activityIndicator.addConstraints([horizontalCenter, verticalCenter])
                }
                
                activityIndicator.hidesWhenStopped = true
                
                if let configureView = configureView {
                    configureView(activityIndicator, self)
                }
                
                self.activityIndicator = activityIndicator
            }
            
            if let activityIndicator = self.activityIndicator {
                activityIndicator.startAnimating()
            } else {
                DDLog.error(message: "Unable to create Activity Indicator for view \(self)")
            }
            
        } else {
            
            if let activityIndicator = self.activityIndicator {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                self.activityIndicator = nil
            }
        }
    }
}
#endif
