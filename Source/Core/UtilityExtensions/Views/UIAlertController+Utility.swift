//
//  UIAlertController+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import UIKit

extension UIAlertController
{
    public class func showAlert(
        title : String? = nil,
        message : String? = nil,
        buttonText : String = "Ok",
        showOver : UIViewController,
        completion completionHandler : (() -> Void)? = nil
        ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: completionHandler)
        }))
        
        showOver.presentViewController(alert, animated: true, completion: nil)
    }
    
    public class func showEmailReportAlert(
        title : String? = nil,
        message : String? = nil,
        defaultButtonText : String = "Ok",
        reportButtonText : String = "Report",
        reportEmailAddress : String,
        reportSubject : String,
        reportBody : String? = nil,
        showOver : UIViewController,
        completion completionHandler : ( (error : NSError?) -> Void)? = nil
        ) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: defaultButtonText, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                alert.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                    if let completionHandler = completionHandler {
                        completionHandler(error: nil)
                    }
                })
            }))
            
            alert.addAction(UIAlertAction(title: reportButtonText, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                alert.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                    let error : NSError?
                    do {
                        try UIApplication.sharedApplication().mailTo(reportEmailAddress, subject: reportSubject, body: reportBody)
                        
                        error = nil
                    } catch let mailToError as NSError {
                        
                        error = mailToError
                    }

                    if let completionHandler = completionHandler {
                        completionHandler(error: error)
                    }
                })
            }))
            
            showOver.presentViewController(alert, animated: true, completion: nil)
    }
    
    public class func deleteActionSheet(
        title : String,
        deleteActionText : String = "Delete",
        cancelActionText : String = "Cancel",
        autoDismiss : Bool = true,
        deleteActionHandler : ((UIAlertAction) -> Void),
        cancelActionHandler : ((UIAlertAction) -> Void)?
        ) -> UIAlertController {
            
        let result = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let deleteAction = UIAlertAction(title: deleteActionText, style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            if autoDismiss
            {
                result.dismissViewControllerAnimated(true, completion: nil)
            }
            
            deleteActionHandler(action)
        })
        result.addAction(deleteAction)
    
        let cancelAction = UIAlertAction(title: cancelActionText, style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            if autoDismiss
            {
                result.dismissViewControllerAnimated(true, completion: nil)
            }

            if let cancelActionHandler = cancelActionHandler
            {
                cancelActionHandler(action)
            }
        })
        result.addAction(cancelAction)
        
        return result
    }
}