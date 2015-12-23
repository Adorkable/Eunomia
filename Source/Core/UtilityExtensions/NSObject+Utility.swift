//
//  NSObject+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import CocoaLumberjack

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
    
    private var associatedObjects: AssociatedPropertyObjects {
        guard let associatedObjects = objc_getAssociatedObject(self, &AssociatedObjectsKey) as? AssociatedPropertyObjects else {
            let associatedObjects = AssociatedPropertyObjects()
            objc_setAssociatedObject(self, &AssociatedObjectsKey, associatedObjects, .OBJC_ASSOCIATION_RETAIN)
            return associatedObjects
        }
        return associatedObjects
    }
    
    public func setAssociatedRetainProperty(key : String, value : AnyObject?) {
        self.associatedObjects[key] = value
    }
    
    public func getAssociatedProperty<T>(key : String) -> T? {
        guard let valueUncasted = self.associatedObjects[key] else {
            return nil
        }
        
        guard let valueCasted = valueUncasted as? T else {
            
            DDLog.debug("In \(self) for Key \(key) found Value \(valueUncasted), that could not be casted to Type \(T.self)")
            return nil
        }
        
        return valueCasted
    }
    
    public func getAssociatedProperty<T>(key : String, fallback : T) -> T {
        guard let value : T = self.getAssociatedProperty(key) else {
            return fallback
        }
        
        return value
    }
}

extension NSObject {
    
    // TODO: because of how selectors are referenced in Swift and that we can't easily add a property to our NSObject extension in Swift is this safer to keep in Objective-C?
    public func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("keyboardDidShow:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("keyboardDidHide:"), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    public func unregisterForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
    }
    
    internal class func getKeyboardChangeInfoValues(notification : NSNotification, inout beginFrame : CGRect?, inout endFrame : CGRect?, inout duration : NSTimeInterval?, inout animationCurve : UIViewAnimationCurve?) {
        
        beginFrame = notification.objectFromInfo(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue
        endFrame = notification.objectFromInfo(UIKeyboardFrameEndUserInfoKey)?.CGRectValue
        duration = notification.objectFromInfo(UIKeyboardAnimationDurationUserInfoKey)?.doubleValue
        if let rawValue = notification.objectFromInfo(UIKeyboardAnimationCurveUserInfoKey)?.integerValue
        {
            animationCurve = UIViewAnimationCurve(rawValue: rawValue)
        }
    }
    
    public func keyboardWillShow(notification : NSNotification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : NSTimeInterval?
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
            DDLog.error("Cannot call keyboardWillShow with info values, unable to retrieve expected info value")
        }
    }
    
    public func keyboardWillShow(beginFrame : CGRect, endFrame : CGRect, duration : NSTimeInterval, animationCurve : UIViewAnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    func keyboardDidShow(notification : NSNotification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : NSTimeInterval?
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
            DDLog.error("Cannot call keyboardDidShow with info values, unable to retrieve expected info value")
        }
    }
    
    public func keyboardDidShow(beginFrame : CGRect, endFrame : CGRect, duration : NSTimeInterval, animationCurve : UIViewAnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    func keyboardWillHide(notification : NSNotification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : NSTimeInterval?
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
            DDLog.error("Cannot call keyboardWillHide with info values, unable to retrieve expected info value")
        }
    }
    
    public func keyboardWillHide(beginFrame : CGRect, endFrame : CGRect, duration : NSTimeInterval, animationCurve : UIViewAnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    func keyboardDidHide(notification : NSNotification) {
        var beginFrame : CGRect?
        var endFrame : CGRect?
        var duration : NSTimeInterval?
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
            DDLog.error("Cannot call keyboardDidHide with info values, unable to retrieve expected info value")
        }
    }
    
    public func keyboardDidHide(beginFrame : CGRect, endFrame : CGRect, duration : NSTimeInterval, animationCurve : UIViewAnimationCurve) {
        self.alignWithKeyboard(beginFrame, endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
    
    public func alignWithKeyboard(beginFrame : CGRect, endFrame : CGRect, duration : NSTimeInterval, animationCurve : UIViewAnimationCurve) {
        
    }
}