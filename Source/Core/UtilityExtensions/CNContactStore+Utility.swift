//
//  CNContactStore+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

import Contacts

@available(iOS 9.0, *)
extension CNContactStore {

    // TODO: SuccessResult?
    public class func requestAccessToContacts(completion: ((granted : Bool, error : NSError?) -> Void)?) {
        let contactStore = CNContactStore()
        
        contactStore.requestAccessForEntityType(CNEntityType.Contacts) { (granted, error) -> Void in

            if let completion = completion
            {
                completion(granted: granted, error: error)
            }
        }
    }
}