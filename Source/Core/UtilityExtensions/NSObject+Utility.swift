//
//  NSObject+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

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
            
            DDLog.debug(message: "In \(self) for Key \(key) found Value \(valueUncasted), that could not be casted to Type \(T.self)")
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
extension NSObject {
    
    // TODO: because of how selectors are referenced in Swift and that we can't easily add a property to our NSObject extension in Swift is this safer to keep in Objective-C?
    public func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("keyboardWillShow:"), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("keyboardDidShow:"), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("keyboardWillHide:"), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("keyboardDidHide:"), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    public func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    internal class func getKeyboardChangeInfoValues(_ notification : Notification, beginFrame : inout CGRect?, endFrame : inout CGRect?, duration : inout TimeInterval?, animationCurve : inout UIViewAnimationCurve?) {
        
        beginFrame = notification.objectFromInfo(UIKeyboardFrameBeginUserInfoKey)?.cgRectValue
        endFrame = notification.objectFromInfo(UIKeyboardFrameEndUserInfoKey)?.cgRectValue
        duration = notification.objectFromInfo(UIKeyboardAnimationDurationUserInfoKey)?.doubleValue
        if let curveValue = notification.objectFromInfo(UIKeyboardAnimationCurveUserInfoKey) as? NSNumber
        {
            animationCurve = UIViewAnimationCurve(rawValue: curveValue.intValue)
        }
    }
    
    public func keyboardWillShow(_ notification : Notification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : TimeInterval?
        var animationCurve : UIViewAnimationCurve?
        NSObject.getKeyboardChangeInfoValues(notification, beginFrame: &beginFrame, endFrame: &endFrame, duration: &duration, animationCurve: &animationCurve)
        
        if let beginFrame = beginFrame,
            let endFrame = endFrame,
            let duration = duration,
            let animationCurve = animationCurve
        {
            self.keyboardWillShow(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
        } else
        {
            DDLog.error(message: "Cannot call keyboardWillShow with info values, unable to retrieve expected info value")
        }
    }
    
    public func keyboardWillShow(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIViewAnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    func keyboardDidShow(_ notification : Notification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : TimeInterval?
        var animationCurve : UIViewAnimationCurve?
        NSObject.getKeyboardChangeInfoValues(notification, beginFrame: &beginFrame, endFrame: &endFrame, duration: &duration, animationCurve: &animationCurve)
        
        if let beginFrame = beginFrame,
            let endFrame = endFrame,
            let duration = duration,
            let animationCurve = animationCurve
        {
            self.keyboardDidShow(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
        } else
        {
            DDLog.error(message: "Cannot call keyboardDidShow with info values, unable to retrieve expected info value")
        }
    }
    
    public func keyboardDidShow(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIViewAnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    func keyboardWillHide(_ notification : Notification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : TimeInterval?
        var animationCurve : UIViewAnimationCurve?
        NSObject.getKeyboardChangeInfoValues(notification, beginFrame: &beginFrame, endFrame: &endFrame, duration: &duration, animationCurve: &animationCurve)
        
        if let beginFrame = beginFrame,
            let endFrame = endFrame,
            let duration = duration,
            let animationCurve = animationCurve
        {
            self.keyboardWillHide(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
        } else
        {
            DDLog.error(message: "Cannot call keyboardWillHide with info values, unable to retrieve expected info value")
        }
    }
    
    public func keyboardWillHide(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIViewAnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    func keyboardDidHide(_ notification : Notification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : TimeInterval?
        var animationCurve : UIViewAnimationCurve?
        NSObject.getKeyboardChangeInfoValues(notification, beginFrame: &beginFrame, endFrame: &endFrame, duration: &duration, animationCurve: &animationCurve)
        
        if let beginFrame = beginFrame,
            let endFrame = endFrame,
            let duration = duration,
            let animationCurve = animationCurve
        {
            self.keyboardDidHide(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
        } else
        {
            DDLog.error(message: "Cannot call keyboardDidHide with info values, unable to retrieve expected info value")
        }
    }
    
    public func keyboardDidHide(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIViewAnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    public func alignWithKeyboard(_ beginFrame : CGRect, endFrame : CGRect, duration : TimeInterval, animationCurve : UIViewAnimationCurve) {
        
    }
}
#endif
