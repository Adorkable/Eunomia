//
//  UIAlertController+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

extension UIAlertController
{
    public class func showAlert(
        _ title : String? = nil,
        message : String? = nil,
        buttonText : String = "Ok",
        showOver : UIViewController,
        completion completionHandler : (() -> Void)? = nil
        ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: completionHandler)
        }))
        
        showOver.present(alert, animated: true, completion: nil)
    }
    
    public class func showEmailReportAlert(
        _ title : String? = nil,
        message : String? = nil,
        defaultButtonText : String = "Ok",
        reportButtonText : String = "Report",
        reportEmailAddress : String,
        reportSubject : String,
        reportBody : String? = nil,
        showOver : UIViewController,
        completion completionHandler : ( (_ error : NSError?) -> Void)? = nil
        ) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: defaultButtonText, style: UIAlertAction.Style.default, handler: { (action) -> Void in
                alert.dismiss(animated: true, completion: { () -> Void in
                    
                    if let completionHandler = completionHandler {
                        completionHandler(nil)
                    }
                })
            }))
            
            alert.addAction(UIAlertAction(title: reportButtonText, style: UIAlertAction.Style.default, handler: { (action) -> Void in
                alert.dismiss(animated: true, completion: { () -> Void in
                    
                    let error : NSError?
                    do {
                        try UIApplication.shared.mailTo(reportEmailAddress, subject: reportSubject, body: reportBody)
                        
                        error = nil
                    } catch let mailToError as NSError {
                        
                        error = mailToError
                    }

                    if let completionHandler = completionHandler {
                        completionHandler(error)
                    }
                })
            }))
            
            showOver.present(alert, animated: true, completion: nil)
    }
    
    public class func deleteActionSheet(
        _ title : String,
        deleteActionText : String = "Delete",
        cancelActionText : String = "Cancel",
        autoDismiss : Bool = true,
        deleteActionHandler : @escaping ((UIAlertAction) -> Void),
        cancelActionHandler : ((UIAlertAction) -> Void)?
        ) -> UIAlertController {
            
        let result = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let deleteAction = UIAlertAction(title: deleteActionText, style: UIAlertAction.Style.destructive, handler: { (action) -> Void in
            if autoDismiss
            {
                result.dismiss(animated: true, completion: nil)
            }
            
            deleteActionHandler(action)
        })
        result.addAction(deleteAction)
    
        let cancelAction = UIAlertAction(title: cancelActionText, style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
            if autoDismiss
            {
                result.dismiss(animated: true, completion: nil)
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
#endif
