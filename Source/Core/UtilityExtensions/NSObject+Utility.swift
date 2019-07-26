//
//  NSObject+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation
import UIKit

import ObjectiveC

// rewrite inspired by https://github.com/tokorom/HasAssociatedObjects
private class AssociatedPropertyObjects: NSObject {
    
    var values: [String: AnyObject] = [:]
    
    subscript(key: String) -> AnyObject? {
        get {
            return self.values[key]
        }
        set {
            self.values[key] = newValue
        }
    }
}

private var AssociatedObjectsKey: UInt8 = 0

extension NSObject {
    
    fileprivate var associatedObjects: AssociatedPropertyObjects {
        guard let associatedObjects = objc_getAssociatedObject(self, &AssociatedObjectsKey) as? AssociatedPropertyObjects else {
            let associatedObjects = AssociatedPropertyObjects()
            objc_setAssociatedObject(self, &AssociatedObjectsKey, associatedObjects, .OBJC_ASSOCIATION_RETAIN)
            return associatedObjects
        }
        return associatedObjects
    }
    
    public func setAssociatedRetainProperty(_ key : String, value : AnyObject?) {
        self.associatedObjects[key] = value
    }
    
    public func getAssociatedProperty<T>(_ key : String) -> T? {
        guard let valueUncasted = self.associatedObjects[key] else {
            return nil
        }
        
        guard let valueCasted = valueUncasted as? T else {
            
            Log.debug(message: "In \(self) for Key \(key) found Value \(valueUncasted), that could not be casted to Type \(T.self)")
            return nil
        }
        
        return valueCasted
    }
    
    public func getAssociatedProperty<T>(_ key : String, fallback : T) -> T {
        guard let value : T = self.getAssociatedProperty(key) else {
            return fallback
        }
        
        return value
    }
}

#if os(iOS)
@objc
protocol KeyboardNotificationsSubscriber {
    @objc optional func alignWithKeyboard(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIView.AnimationCurve)
}

extension NSObject {
    
    // TODO: because of how selectors are referenced in Swift and that we can't easily add a property to our NSObject extension in Swift is this safer to keep in Objective-C?
    public func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("keyboardWillShow:"), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("keyboardDidShow:"), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("keyboardWillHide:"), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("keyboardDidHide:"), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    public func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    internal class func getKeyboardChangeInfoValues(_ notification : Notification, beginFrame : inout CGRect?, endFrame : inout CGRect?, duration : inout TimeInterval?, animationCurve : inout UIView.AnimationCurve?) {
        
        beginFrame = notification.objectFromInfo(UIResponder.keyboardFrameBeginUserInfoKey)?.cgRectValue
        endFrame = notification.objectFromInfo(UIResponder.keyboardFrameEndUserInfoKey)?.cgRectValue
        duration = notification.objectFromInfo(UIResponder.keyboardAnimationDurationUserInfoKey)?.doubleValue
        if let curveValue = notification.objectFromInfo(UIResponder.keyboardAnimationCurveUserInfoKey) as? NSNumber
        {
            animationCurve = UIView.AnimationCurve(rawValue: curveValue.intValue)
        }
    }
    
    @objc open func keyboardWillShow(_ notification : Notification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : TimeInterval?
        var animationCurve : UIView.AnimationCurve?
        NSObject.getKeyboardChangeInfoValues(notification, beginFrame: &beginFrame, endFrame: &endFrame, duration: &duration, animationCurve: &animationCurve)
        
        if let beginFrame = beginFrame,
            let endFrame = endFrame,
            let duration = duration,
            let animationCurve = animationCurve
        {
            self.keyboardWillShow(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
        } else
        {
            Log.error(message: "Cannot call keyboardWillShow with info values, unable to retrieve expected info value")
        }
    }
    
    @objc open func keyboardWillShow(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIView.AnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    @objc open func keyboardDidShow(_ notification : Notification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : TimeInterval?
        var animationCurve : UIView.AnimationCurve?
        NSObject.getKeyboardChangeInfoValues(notification, beginFrame: &beginFrame, endFrame: &endFrame, duration: &duration, animationCurve: &animationCurve)
        
        if let beginFrame = beginFrame,
            let endFrame = endFrame,
            let duration = duration,
            let animationCurve = animationCurve
        {
            self.keyboardDidShow(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
        } else
        {
            Log.error(message: "Cannot call keyboardDidShow with info values, unable to retrieve expected info value")
        }
    }
    
    @objc open func keyboardDidShow(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIView.AnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    @objc open func keyboardWillHide(_ notification : Notification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : TimeInterval?
        var animationCurve : UIView.AnimationCurve?
        NSObject.getKeyboardChangeInfoValues(notification, beginFrame: &beginFrame, endFrame: &endFrame, duration: &duration, animationCurve: &animationCurve)
        
        if let beginFrame = beginFrame,
            let endFrame = endFrame,
            let duration = duration,
            let animationCurve = animationCurve
        {
            self.keyboardWillHide(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
        } else
        {
            Log.error(message: "Cannot call keyboardWillHide with info values, unable to retrieve expected info value")
        }
    }
    
    @objc open func keyboardWillHide(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIView.AnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    @objc open func keyboardDidHide(_ notification : Notification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : TimeInterval?
        var animationCurve : UIView.AnimationCurve?
        NSObject.getKeyboardChangeInfoValues(notification, beginFrame: &beginFrame, endFrame: &endFrame, duration: &duration, animationCurve: &animationCurve)
        
        if let beginFrame = beginFrame,
            let endFrame = endFrame,
            let duration = duration,
            let animationCurve = animationCurve
        {
            self.keyboardDidHide(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
        } else
        {
            Log.error(message: "Cannot call keyboardDidHide with info values, unable to retrieve expected info value")
        }
    }
    
    @objc open func keyboardDidHide(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIView.AnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    @objc open func alignWithKeyboard(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIView.AnimationCurve) {
    }
}
#endif
